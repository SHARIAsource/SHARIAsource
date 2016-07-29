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
      doc_ids.each do |doc_id|
        PdfToImagesWorker.perform_async(doc_id, true)
      end
    end

    desc 'Regenerate JPG images for PDFs without text'
    task sans_text: :environment do
      doc_count = Document.count
      query = 'document_style = ? OR document_style = ?', 'scan', 'scannotext'
      doc_ids = Document.where(query).select do |doc|
        !doc.pdf.current_path.nil?
      end.map(&:id)
      puts doc_ids.size
      documents = Document.find(doc_ids)
      documents.each { |doc| doc.update! processed: false } unless documents.blank?
      doc_ids.each do |doc_id|
        PdfToImagesWorker.perform_async(doc_id)
      end
    end
  end
end
