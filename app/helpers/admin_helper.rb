module AdminHelper
  def item_processed?(item)
    defined?(item.processed) && item.processed
  end
end
