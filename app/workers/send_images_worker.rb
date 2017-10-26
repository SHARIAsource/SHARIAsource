class SendImagesWorker
  include Sidekiq::Worker

  def perform(image_id)
    image = image.find image_id
    api = Corpusbuilder::Ruby::Api.new
    api.create_image(image)
  end
end
