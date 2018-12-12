module AdminHelper
  def admin_title(page_title)
    [page_title, 'Application Admin'].flatten.reject(&:empty?).join ' | '
  end
end
