# -*- coding: utf-8 -*-
class DocumentPresenter < BasePresenter
  include ActionView::Helpers::SanitizeHelper
  include ActionView::Helpers::UrlHelper
  include Rails.application.routes.url_helpers

  REFERENCE_LIMIT = 3

  def author_or_contributor
    authors.any? ? authors_together : contributors_together
  end

  def authors_together
    authors.map do |author|
      if author.user
        link_to(author.name, editors_and_contributor_path(author.user)).html_safe
      else
        author.name
      end
    end.each_with_index.inject("") do |state, iter|
      body, ix = iter

      if state != ""
        if ix == authors.count - 1
          "#{state} and #{body}"
        else
          "#{state}, #{body}"
        end
      else
        body
      end
    end.html_safe
  end

  def editors_together
    editors.map(&:name).to_sentence
  end

  def translators_together
    translators.map(&:name).to_sentence
  end

  def contributors_together
    contributors.map { |c| "#{c.first_name} #{c.last_name}" }.join(', ')
  end

  def alternate_authors
    if @object.alternate_authors.present?
      @object.alternate_authors
    else
      return author if author.nil?

      author.map(&:name).to_sentence
    end
  end

  def alternate_editors
    if @object.alternate_editors.present?
      @object.alternate_editors
    else
      return editors if editors.nil?

      editors.map(&:name).to_sentence
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
      return translators if translators.nil?

      translators.map(&:name).to_sentence
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
    result = [authors_together]
    if editors.any?
      result << "Edited by #{editors_together}"
    end
    if translators.any?
      result << "Translated by #{translators_together}"
    end

    result.join(', ').html_safe
  end

  def dates
    gregorian = []
    lunar_hijri = []
    if gregorian_year.present?
      gregorian << gregorian_year
      lunar_hijri << lunar_hijri_year
      if gregorian_month.present?
        gregorian.unshift(I18n.translate('date.month_names', locale: :en)[gregorian_month])
        lunar_hijri.unshift(I18n.translate('date.month_names', locale: :en_ar)[lunar_hijri_month])
        if gregorian_day.present?
          gregorian.unshift(gregorian_day)
          lunar_hijri.unshift(lunar_hijri_day)
        end
      end
      "#{lunar_hijri.join(' ')} / #{gregorian.join(' ')}"
    else
      month = I18n.translate('date.month_names',
                             locale: :en_ar)[lunar_hijri_month]
      [
        "#{lunar_hijri_year} #{month} #{lunar_hijri_year}",
        gregorian_date.to_s(:dd_month_yyyy)
      ].join(' / ')
    end
  end

  def document_types
    document_type.self_and_ancestors.pluck(:name).reverse
  end

  def email_share_url(document_url)
    [
      'mailto:?subject=SHARIAsource.com: ',
      CGI.escape("#{title} by #{author_or_contributor}"),
      '&body=',
      CGI.escape("#{title} by #{author_or_contributor}"),
      CGI.escape("\n\n"),
      CGI.escape(document_url)
    ].join('')
  end

  def facebook_description
    if summary.present?
      summary
    elsif pages.present?
      strip_tags(pages[0].body.text).slice(0, 200) + '…'
    elsif body.present?
      strip_tags(body.text).slice(0, 200) + '…'
    end
  end

  def facebook_share_url(document_url)
    url = CGI.escape document_url
    "http://www.facebook.com/sharer/sharer.php?u=#{url}"
  end

  def other_documents
    pluralized = 'document'.pluralize(other_documents_count)
    "+ #{other_documents_count} other #{pluralized}"
  end

  def other_documents_count
    @object.referenced_documents.count - REFERENCE_LIMIT
  end

  def posted_by_author?
    authors.empty? || (authors.any? && authors.first.name == contributors.first.name)
  end

  def published_at
    @object.published_at || Time.now
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

  def owned_referenced_documents(user)
    @object.referenced_documents.select{ |doc| doc.viewable_by?(user) && !doc.published}.map do |document|
      DocumentPresenter.new document
    end
  end

  def owned_referencing_documents(user)
    @object.referencing_documents.select{ |doc| doc.viewable_by?(user) && !doc.published}.map do |document|
      DocumentPresenter.new document
    end
  end

  def viewable_by?(user)
    return @object.published? if user.nil?

    user.is_superuser? || user.is_editor? || self.user == user || contributors.first.self_and_ancestors.include?(user)
  end

  def title_with_author
    if authors.any?
      title + ' by ' + authors_together
    elsif contributors.any?
      title + ' ed. ' + contributors_together
    end
  end

  def twitter_share_url(document_url)
    url = CGI.escape(document_url)
    title_length_max = 90 - author_or_contributor.length

    if title_length_max > 0
      shortened_title = short_title(title, title_length_max)

      [
        "https://twitter.com/share?url=#{url}",
        '&via=SHARIAsource&text=',
        CGI.escape("#{shortened_title} by #{author_or_contributor}")
      ].join('')
    else
      title_length_max = 90
      shortened_title = short_title(title, title_length_max)

      [
        "https://twitter.com/share?url=#{url}",
        '&via=SHARIAsource&text=',
        CGI.escape("#{shortened_title}")
      ].join('')
    end
  end

  def short_title(title, title_length_max)
    shortened_title = title

    if title.length > title_length_max
      shortened_title = title.slice(0, title_length_max)
      if shortened_title.slice(-1) == " "
        shortened_title = shortened_title.strip
      else
        shortened_title = shortened_title.split(' ')
        shortened_title.pop
        shortened_title = shortened_title.join(' ')
      end
      shortened_title += '…'
    end

    shortened_title
  end

  def years
    if lunar_hijri_date.present? || gregorian_date.present?
      [lunar_hijri_date, gregorian_date].compact.map(&:year).join(' / ')
    else
      @object.created_at.year
    end
  end
end
