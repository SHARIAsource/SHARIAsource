class SearchesController < ApplicationController
  def show
    @filters = SearchFilters.new permitted_params
    @languages = Language.all
    @authors = User.all
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
      query.with(:contributor_id, @filters.author) if @filters.author
      query.with(:region_ids, @filters.region) if @filters.region
      query.with(:era_ids, @filters.era) if @filters.era
      if @filters.document_type
        query.with(:document_type_id, @filters.document_type)
      end
      if @filters.sort.present?
        query.order_by(order_field(@filters.sort),
                       order_direction(@filters.sort))
      end
    end
  end

  private

  def permitted_params
    params.permit(:q, :date_from, :date_to, :date_format, :sort,
                  document_type: [], language: [], author: [], topic: [],
                  theme: [], region: [], era: [])
  end

  def order_field(order)
    case order
    when 'recent' then :created_at
    when 'oldest' then :created_at
    when 'author' then :sort_author
    end
  end

  def order_direction(order)
    order == 'recent' ? :desc : :asc
  end
end
