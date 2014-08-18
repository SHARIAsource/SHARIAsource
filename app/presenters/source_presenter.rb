class SourcePresenter < BasePresenter
  def referenced_documents
    @object.referenced_sources.take(NUM_REFERENCES_DISPLAYED).map do |source|
      SourcePresenter.new source
    end
  end

  def other_documents_count
    @object.referenced_sources.count - NUM_REFERENCES_DISPLAYED
  end

  def other_documents
    pluralized = 'document'.pluralize(other_documents_count)
    "+ #{other_documents_count} other #{pluralized}"
  end

  def title_with_author
    [@object.title, @object.author].reject(&:empty?).join ' by '
  end
end
