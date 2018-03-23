module AdminHelper
  def admin_title(page_title)
    [page_title, 'SHARIAsource Admin'].flatten.reject(&:empty?).join ' | '
  end

  def corpusbuilder_uploader(document)
    if document.ocr_document_id.present?
      render partial: "admin/shared/corpusbuilder_document_status", locals: {
        corpusbuilder_public_url: Corpusbuilder::Ruby::Api.config.public_url,
        editor_email: current_user.email,
        document: document
      }
    else
      render partial: "admin/shared/corpusbuilder_uploader", locals: {
        corpusbuilder_public_url: Corpusbuilder::Ruby::Api.config.public_url,
        editor_email: current_user.email,
        document: document
      }
    end
  end
end
