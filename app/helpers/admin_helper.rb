module AdminHelper
  def admin_title(page_title)
    [page_title, 'SHARIAsource Admin'].flatten.reject(&:empty?).join ' | '
  end

  def corpusbuilder_uploader
    render partial: "admin/shared/corpusbuilder_uploader", locals: {
      corpusbuilder_public_url: Corpusbuilder::Ruby::Api.config.public_url,
      editor_email: 'kamil@endpoint.com'
    }
  end
end
