class DocumentPresenter < BasePresenter
  REFERENCE_LIMIT = 3

  def dates
    hijri = I18n.l(@object.lunar_hijri_date, format: :dd_month_yyyy,
                   locale: :en_ar)
    gregorian = @object.gregorian_date.to_s :dd_month_yyyy
    [hijri, gregorian].reject(&:empty?).join(' / ')
  end

  def edited_by
    if @object.editors.present?
      "Edited by #{@object.editors}"
    else
      ''
    end
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
    @object.referenced_documents.map do |document|
      DocumentPresenter.new document
    end
  end

  def referencing_documents
    @object.referencing_documents.map do |document|
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
