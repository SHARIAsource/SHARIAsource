module AdminHelper
  def admin_title(page_title)
    [page_title, 'SHARIAsource Admin'].flatten.reject(&:empty?).join ' | '
  end
end
