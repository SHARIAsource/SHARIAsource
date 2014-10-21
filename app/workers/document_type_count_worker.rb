class DocumentTypeCountWorker
  include Sidekiq::Worker

  def perform
    ['topic', 'theme', 'era', 'region', 'contributor'].each do |category|
      key = "document_type_#{category}_counts"
      val = DocumentTypeCounter.public_send "#{category}_counts"
      Rails.cache.write(key, val)
    end
  end
end
