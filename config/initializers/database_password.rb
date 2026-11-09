# Read the database password from Secrets Manager when a connection opens, so
# an RDS rotation does not strand running tasks. Postgres keeps authenticated
# sessions open across a password change, so pooled connections survive and
# only new ones need the new value. On when RDS_SECRET_ARN is set; otherwise
# database.yml applies as before.
module DatabasePassword
  @mutex = Mutex.new

  class << self
    def enabled?
      !ENV['RDS_SECRET_ARN'].to_s.empty?
    end

    def password(refresh: false)
      @mutex.synchronize do
        @password = fetch if refresh || @password.nil?
        @password
      end
    end

    def reset!
      @mutex.synchronize { @password = nil }
    end

    private

    def fetch
      require 'aws-sdk-secretsmanager'
      secret = Aws::SecretsManager::Client.new.get_secret_value(secret_id: ENV['RDS_SECRET_ARN'])
      JSON.parse(secret.secret_string).fetch('password')
    end
  end

  # Prepended onto PostgreSQLAdapter's singleton class. Rails 6.1 opens every
  # raw connection through new_client, so this is the one place to set it.
  module NewClient
    def new_client(conn_params)
      return super unless DatabasePassword.enabled?

      super(conn_params.merge(password: DatabasePassword.password))
    rescue ActiveRecord::ActiveRecordError
      # ponytail: any failure refetches once. The seconds between RDS switching
      # the password and moving AWSCURRENT still fail; the next connection
      # succeeds.
      super(conn_params.merge(password: DatabasePassword.password(refresh: true)))
    end
  end
end

if DatabasePassword.enabled?
  require 'active_record/connection_adapters/postgresql_adapter'
  ActiveRecord::ConnectionAdapters::PostgreSQLAdapter.singleton_class.prepend(DatabasePassword::NewClient)
end
