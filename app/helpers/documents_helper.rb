module DocumentsHelper
  def corpusbuilder_document(document)
    if document.ocr_document_id.present?
      render partial: "shared/corpusbuilder_document", locals: {
        editor_email: current_user.try(:email),
        document: document
      }
    end
  end
end
