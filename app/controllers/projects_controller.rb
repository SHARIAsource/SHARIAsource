class ProjectsController < ApplicationController
  before_filter :fetch_data, :fetch_filters

  def show
  end

  def search
    render :show
  end

  private

  def fetch_filters
    filter_id = params[:named_filter_id]
    @filters = filter_id.present? ? NamedFilter.find(filter_id) : NamedFilter.new
    @search = Document.search do |query|
      query.fulltext @filters.q
      query.with(:published, true)
      query.with(:contributor_id, @filters.contributor.id) if @filters.contributor.present?
      query.with(:region_ids, @filters.region.id) if @filters.region.present?
      query.with(:language_id, [@filters.language.id]) if @filters.language.present?
      query.with(:document_type_id, [@filters.document_type.id]) if @filters.document_type.present?
      query.with(:theme_ids, [@filters.theme.id]) if @filters.theme.present?
      query.with(:topic_ids, [@filters.topic.id]) if @filters.topic.present?
      query.with(:era_ids, [@filters.era.id]) if @filters.era.present?
    end
  end

  def fetch_data
    @project = Project.find params[:id]
    @languages = Language.rank(:sort_order)
    @languages = Language.rank(:sort_order)
    @contributors = User.joins(:documents).distinct
    @topics = Topic.all
    @themes = Theme.all
    @regions = Region.hash_tree
    @eras = Era.hash_tree
    @document_types = DocumentType.hash_tree
  end
end
