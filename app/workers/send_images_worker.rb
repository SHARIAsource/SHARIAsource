class SendImagesWorker
  include Sidekiq::Worker

  def perform(filepaths, document_id, processed_image_ids=[])
    #this worker is being called recursively until all images have been processed
    if filepaths.empty?
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
        #minutes_til_resend = 1
        #SendImagesWorker.perform_in(minutes_til_resend.minute, filepaths, document_id, processed_image_ids)
        ocr_state = Document.find(document_id).ocr_state

        ocr_state.set_error_message(e)
        Rails.logger.error "Error sending images to Corpusbuilder: #{e}, resending in #{minutes_til_resend} minute"
        raise "#{e}"
      end
    end
  end
end
