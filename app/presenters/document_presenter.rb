class DocumentPresenter < BasePresenter
  REFERENCE_LIMIT = 3

  def referenced_documents
    @object.referenced_documents.take(REFERENCE_LIMIT).map do |document|
      DocumentPresenter.new document
    end
  end

  def other_documents_count
    @object.referenced_documents.count - REFERENCE_LIMIT
  end

  def other_documents
    pluralized = 'document'.pluralize(other_documents_count)
    "+ #{other_documents_count} other #{pluralized}"
  end

  def title_with_author
    [@object.title, @object.contributor.name].reject(&:empty?).join ' by '
  end
end
