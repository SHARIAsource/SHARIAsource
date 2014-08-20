class DocumentPresenter < BasePresenter
  REFERENCE_LIMIT = 3

  def bylines
    byline = []
    if @object.author.present?
      byline << @object.author
    end
    if @object.editors.present?
      byline << "Edited by #{@object.editors}"
    end
    if @object.translators.present?
      byline << "Translated by #{@object.translators}"
    end
    byline.join ', '
  end

  def dates
    hijri = I18n.l(@object.lunar_hijri_date, format: :dd_month_yyyy,
                   locale: :en_ar)
    gregorian = @object.gregorian_date.to_s :dd_month_yyyy
    [hijri, gregorian].reject(&:empty?).join(' / ')
  end

  def document_types
    @object.document_type.self_and_ancestors.pluck(:name).reverse
  end

  def other_documents
    pluralized = 'document'.pluralize(other_documents_count)
    "+ #{other_documents_count} other #{pluralized}"
  end

  def other_documents_count
    @object.referenced_documents.count - REFERENCE_LIMIT
  end

  def referenced_documents
    @object.referenced_documents.take(REFERENCE_LIMIT).map do |document|
      DocumentPresenter.new document
    end
  end

  def title_with_author
    [@object.title, @object.contributor.name].reject(&:empty?).join ' by '
  end

  def years
    [
      @object.lunar_hijri_date,
      @object.gregorian_date
    ].compact.map(&:year).join(' / ')
  end
end
