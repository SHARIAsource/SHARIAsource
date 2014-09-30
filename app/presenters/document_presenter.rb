class DocumentPresenter < BasePresenter
  REFERENCE_LIMIT = 3

  def alternate_authors
    if @object.alternate_authors.present?
      @object.alternate_authors
    else
      author
    end
  end

  def alternate_editors
    if @object.alternate_editors.present?
      @object.alternate_editors
    else
      editors
    end
  end

  def alternate_titles
    if @object.alternate_titles.present?
      @object.alternate_titles
    else
      title
    end
  end

  def alternate_translators
    if @object.alternate_translators.present?
      @object.alternate_translators
    else
      translators
    end
  end

  def alternate_years
    if @object.alternate_years.present?
      @object.alternate_years
    else
      years
    end
  end

  def byline
    result = [@object.author]
    if editors.present?
      result << "Edited by #{editors}"
    end
    if translators.present?
      result << "Translated by #{translators}"
    end
    result.join(', ')
  end

  def dates
    result = []
    if lunar_hijri_date.present?
      lhd = lunar_hijri_date
      month = I18n.translate('date.month_names', locale: :en_ar)[lhd.month.to_i]
      result << "#{lhd.day} #{month} #{lhd.year}"
    end
    if gregorian_date.present?
      result << gregorian_date.to_s(:dd_month_yyyy)
    end
    if result.present?
      result.join(' / ')
    else
      created_at
    end
  end

  def document_types
    document_type.self_and_ancestors.pluck(:name).reverse
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
    [title, contributor.name].reject(&:empty?).join ' by '
  end

  def years
    if lunar_hijri_date.present? || gregorian_date.present?
      [lunar_hijri_date, gregorian_date].compact.map(&:year).join(' / ')
    else
      @object.created_at.year
    end
  end
end
