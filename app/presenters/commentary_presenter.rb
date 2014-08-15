class CommentaryPresenter
  NUM_REFERENCES_DISPLAYED = 3

  def initialize(commentary)
    @commentary = commentary
  end

  def created_at
    @commentary.created_at.to_s :dd_month_yyyy
  end

  def author
    @commentary.contributor.name
  end

  def referenced_documents
    @commentary.sources.take(NUM_REFERENCES_DISPLAYED).map do |source|
      SourcePresenter.new source
    end
  end

  def other_documents_count
    @commentary.sources.count - NUM_REFERENCES_DISPLAYED
  end

  def other_documents
    pluralized = 'document'.pluralize(other_documents_count)
    "+ #{other_documents_count} other #{pluralized}"
  end

  def method_missing(method)
    @commentary.send(method) rescue nil
  end
end
