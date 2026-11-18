require 'spec_helper'

RSpec.describe DatabasePassword do
  let(:adapter) { ActiveRecord::ConnectionAdapters::PostgreSQLAdapter }
  let(:params) { { user: 'sources', dbname: 'sources', password: 'from-database-yml' } }

  def stub_secret(*passwords)
    responses = passwords.map { |p| { secret_string: { username: 'sources', password: p }.to_json } }
    client = Aws::SecretsManager::Client.new(region: 'us-east-1', stub_responses: { get_secret_value: responses })
    allow(Aws::SecretsManager::Client).to receive(:new).and_return(client)
  end

  before do
    ENV['RDS_SECRET_ARN'] = 'arn:aws:secretsmanager:us-east-1:123456789012:secret:test'
    load Rails.root.join('config/initializers/database_password.rb')
    DatabasePassword.reset!
  end

  after { ENV.delete('RDS_SECRET_ARN') }

  it 'connects with the password from the secret, not database.yml' do
    stub_secret('first')
    expect(PG).to receive(:connect).with(hash_including(password: 'first')).and_return(:conn)
    expect(adapter.new_client(params)).to eq(:conn)
  end

  it 'caches the password across connections' do
    stub_secret('first', 'second')
    expect(PG).to receive(:connect).with(hash_including(password: 'first')).twice.and_return(:conn)
    2.times { adapter.new_client(params) }
  end

  it 'refetches once and retries when the connection is refused' do
    stub_secret('stale', 'rotated')
    expect(PG).to receive(:connect).with(hash_including(password: 'stale')).ordered
      .and_raise(PG::ConnectionBad, 'FATAL: password authentication failed for user "sources"')
    expect(PG).to receive(:connect).with(hash_including(password: 'rotated')).ordered.and_return(:conn)
    expect(adapter.new_client(params)).to eq(:conn)
  end

  it 'gives up after the retry fails' do
    stub_secret('stale', 'still-stale')
    allow(PG).to receive(:connect).and_raise(PG::ConnectionBad, 'FATAL: password authentication failed for user "sources"')
    # Rails 6.1 raises NoDatabaseError or ConnectionNotEstablished depending on the message text.
    expect { adapter.new_client(params) }.to raise_error(ActiveRecord::ActiveRecordError)
  end

  it 'leaves the adapter alone without RDS_SECRET_ARN' do
    ENV.delete('RDS_SECRET_ARN')
    expect(Aws::SecretsManager::Client).not_to receive(:new)
    expect(PG).to receive(:connect).with(hash_including(password: 'from-database-yml')).and_return(:conn)
    adapter.new_client(params)
  end
end
