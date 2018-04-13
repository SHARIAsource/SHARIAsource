class SearchesController < ApplicationController
  def show
    @filters = SearchFilters.new permitted_params
    date_from, date_to = parse_dates
    @languages = Language.rank(:sort_order)
    @contributors = User.joins(:documents).distinct
    @topics = Topic.all
    @themes = Theme.all
    @regions = Region.hash_tree
    @eras = Era.hash_tree
    @document_types = DocumentType.hash_tree
    @search = Document.search do |query|
      query.fulltext @filters.q
      query.with(:published, true)
      query.with(:topic_ids, @filters.topic) if @filters.topic
      query.with(:theme_ids, @filters.theme) if @filters.theme
      query.with(:language_id, @filters.language) if @filters.language
      query.with(:contributor_ids, @filters.contributor) if @filters.contributor
      query.with(:region_ids, @filters.region) if @filters.region
      query.with(:era_ids, @filters.era) if @filters.era
      if @filters.document_type
        query.with(:document_type_id, @filters.document_type)
      end
      if @filters.sort.present?
        query.order_by(order_field(@filters.sort),
                       order_direction(@filters.sort))
      end
      if @filters.date_format == 'ce'
        query.with(:gregorian_date).greater_than(date_from) if date_from
        query.with(:gregorian_date).less_than(date_to) if date_to
      elsif @filters.date_format == 'ah'
        query.with(:lunar_hijri_date).greater_than(date_from) if date_from
        query.with(:lunar_hijri_date).less_than(date_to) if date_to
      end
      query.paginate page: @filters.page, per_page: 20
    end
  end

  private

  def permitted_params
    params.permit(:utf8, :q, :date_from, :date_to, :date_format, :sort, :page,
                  document_type: [], language: [], contributor: [], topic: [],
                  theme: [], region: [], era: [])
  end

  def order_field(order)
    case order
    when 'recent' then :gregorian_date
    when 'oldest' then :gregorian_date
    when 'author' then :sort_author
    end
  end

  def order_direction(order)
    order == 'recent' ? :desc : :asc
  end

  def parse_dates
    dates = [@filters.date_from, @filters.date_to].map do |date|
      if date.present?
        parts = date.split '/'
        if parts.length < 4
          parts.reverse!.map!(&:to_i)
          (3 - parts.length).times { parts.push(1) }
          DateTime.new(*parts)
        end
      end
    end
    dates[1] = dates[1] + 1.day if dates[1]
    dates
  end
end
