class SendImagesWorker
  include Sidekiq::Worker

  def perform(filepaths, processed_image_ids=[])
    if filepaths.empty?
    #Start CreateDocument Worker with processed_image_ids
    #SendDocumentWorker.perform_async(@document.id)
    else
      api = Corpusbuilder::Ruby::Api.new
      begin
        image_file =  File.new(filepaths[0])
        image_id = api.send_image({ :file => image_file, :name => image_file.path.split("/")[-1]})

        filepaths.shift
        processed_image_ids.push image_id
        SendImagesWorker.new.perform(filepaths, processed_image_ids)
      rescue Exception => e
        Rails.logger.error "Error inside action: #{e}"
      end
    end
  end
end
