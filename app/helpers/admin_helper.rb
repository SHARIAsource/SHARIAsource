module AdminHelper
  def item_processed?(item)
    defined?(item.processed) && item.processed
  end

  def admin_title(page_title)
    [page_title, 'SHARIAsource Admin'].flatten.reject(&:empty?).join ' | '
  end
end
