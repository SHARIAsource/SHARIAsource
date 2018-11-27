class NotifyInactiveEditorsWorker
  include Sidekiq::Worker

  def perform(id, action)
  end

  def users
    Document.where("created_at > ?", 3.months.ago).map do |doc|
      users = doc.contributors.to_a
      users += User.where(
        "first_name || ' ' || last_name IN (?)",
        doc.editors.map(&:name) + doc.translators.map(&:name)
      ).to_a
      users
    end.flatten.uniq
  end
end

