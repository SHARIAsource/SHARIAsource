namespace :pdf do
  desc 'Regenerate JPG images for PDFs'
  task regenerate: :environment do
    doc_count = Document.count
    query = "document_style = ? OR document_style = ?", "scan", "scannotext"
    doc_ids = Document.where(query).select do |doc|
      !doc.pdf.current_path.nil?
    end.map(&:id)
    RegenerateImageWorker.perform_async(doc_ids)
  end
end
