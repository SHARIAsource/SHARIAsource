class CommentaryPresenter < BasePresenter
  def author
    @object.contributor.name
  end

  def referenced_documents
    @object.sources.take(NUM_REFERENCES_DISPLAYED).map do |source|
      SourcePresenter.new source
    end
  end

  def other_documents_count
    @object.sources.count - NUM_REFERENCES_DISPLAYED
  end

  def other_documents
    pluralized = 'document'.pluralize(other_documents_count)
    "+ #{other_documents_count} other #{pluralized}"
  end
end
