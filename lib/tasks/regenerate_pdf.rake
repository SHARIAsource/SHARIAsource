namespace :pdf do
  namespace :regenerate do
    desc 'Regenerate JPG images for PDFs with text'
    task with_text: :environment do
      doc_count = Document.count
      query = 'document_style = ? OR document_style = ?', 'scan', 'scannotext'
      doc_ids = Document.where(query).select do |doc|
        !doc.pdf.current_path.nil?
      end.map(&:id)

      documents = Document.find(doc_ids)
      documents.each { |doc| doc.update! processed: false } unless documents.blank?
      processing = false
      current = doc_ids.pop
      while doc_ids.any?
        if processing
          if Document.find(current).processed
            Rails.logger.info "Regenerated images for document with id #{current},
                               #{doc_ids.size} documents to go!"
            processing = false
            current = doc_ids.pop
          else
            sleep(5)
          end
        else
          PdfToImagesWorker.perform_async(current, true)
          processing = true
        end
      end
    end

    desc 'Regenerate JPG images for PDFs without text'
    task sans_text: :environment do
      doc_count = Document.count
      query = 'document_style = ? OR document_style = ?', 'scan', 'scannotext'
      doc_ids = Document.where(query).select do |doc|
        !doc.pdf.current_path.nil?
      end.map(&:id)

      documents = Document.find(doc_ids)
      documents.each { |doc| doc.update! processed: false } unless documents.blank?
      processing = false
      current = doc_ids.pop
      while doc_ids.any?
        if processing
          if Document.find(current).processed
            Rails.logger.info "Regenerated images for document with id #{current},
                               #{doc_ids.size} documents to go!"
            processing = false
            current = doc_ids.pop
          else
            sleep(5)
          end
        else
          PdfToImagesWorker.perform_async(current)
          processing = true
        end
      end
    end
  end
end
