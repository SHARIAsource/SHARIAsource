require 'sidekiq'

class PdfToImagesWorker
  include Sidekiq::Worker

  def perform(pdf_id)
    puts pdf_id
  end
end
