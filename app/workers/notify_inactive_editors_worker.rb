class NotifyInactiveEditorsWorker
  include Sidekiq::Worker

  def perform
    users.each do |user|
      EditorMailer.inactivity_email(user).deliver
    end
  end

  def users
    @_users ||= (User.editors.to_a - skip_users)
  end

  def skip_users
    @_skip_users ||= -> {
      Document.where("created_at > ?", 3.months.ago).map do |doc|
        users = doc.contributors.to_a
        users += User.where(
          "first_name || ' ' || last_name IN (?)",
          doc.editors.map(&:name) + doc.translators.map(&:name)
        ).to_a
        users
      end.flatten.uniq
    }.call
  end
end

