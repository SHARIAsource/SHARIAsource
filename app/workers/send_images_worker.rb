class SendImagesWorker
  include Sidekiq::Worker

  def perform(filepaths, document_id, processed_image_ids=[])
    if filepaths.empty?
    #Start CreateDocument Worker with processed_image_ids
    CreateDocumentWorker.perform_async(processed_image_ids, document_id)
    else
      api = Corpusbuilder::Ruby::Api.new
      begin
        image_file =  File.new(filepaths[0])
        resp = api.send_image({ :file => image_file, :name => image_file.path.split("/")[-1]})

        filepaths.shift
        processed_image_ids.push resp
        SendImagesWorker.new.perform(filepaths, document_id, processed_image_ids)
      rescue Exception => e
        Rails.logger.error "Error sending images to Corpusbuilder: #{e}"
      end
    end
  end
end
