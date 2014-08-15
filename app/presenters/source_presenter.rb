class SourcePresenter
  def initialize(source)
    @source = source
  end

  def title_with_author
    [@source.title, @source.author].reject(&:empty?).join ' by '
  end

  def object
    @source
  end

  def method_missing(method)
    @source.send(method) rescue nil
  end
end
