class ProjectsController < ApplicationController
  before_filter :fetch_data, :fetch_filters

  def show
  end

  def search
    render :show
  end

  private
  #this function allows a  user to check multiple 'Additional Searches' on the projects page
  def inject_ids(filters,attribute)
    logger.debug "Injecting #{attribute}"
    filters.inject([]) { |array_of_ids, filter| array_of_ids = [] if array_of_ids.nil?; array_of_ids.push filter.try(attribute).id if filter.try(attribute).present?; array_of_ids }
  end

  def fetch_filters
    filter_ids = params[:named_filter_id]
    @filters = filter_ids.present? ? NamedFilter.find(filter_ids) : NamedFilter.new
    #if this method  is being hit by clicking checkboxes on projects show page it will be an array
    #if not it will just be an instance of the NamedFilter class
    logger.debug "Document Type: #{@filters.inspect}"
    filters = @filters
    if @filters.class == Array
      @search = Document.search do |query|
        query.all_of do
          logger.debug "Filters: #{filters}"
          query.fulltext filters.inject(nil) { |fulltext, filter_text| fulltext or filter_text.q }
          query.with(:published, true)
          query.with(:contributor_id, inject_ids(filters,'contributor')) unless inject_ids(filters,'contributor').empty?
          query.with(:region_ids, inject_ids(filters,'region')) unless inject_ids(filters,'region').empty?
          query.with(:language_id, inject_ids(filters,'language')) unless inject_ids(filters,'language').empty?
          query.with(:document_type_id, inject_ids(filters,'document_type')) unless inject_ids(filters,'document_type').empty?
          query.with(:theme_ids, inject_ids(filters,'theme')) unless inject_ids(filters,'theme').empty?
          query.with(:topic_ids, inject_ids(filters,'topic')) unless inject_ids(filters,'topic').empty?
          query.with(:era_ids, inject_ids(filters,'era')) unless inject_ids(filters,'era').empty?
          query.paginate :page => 1, :per_page => 5
        end
      end
      logger.debug "Search: #{@search.inspect}"
    else
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
        query.paginate :page => 1, :per_page => 5
     end
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
