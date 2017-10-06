class ProjectsController < ApplicationController
  before_filter :fetch_data, :fetch_filters

  def show
  end

  def search
    render :show
  end

  private
  #this function allows a  user to check multiple 'Additional Searches' on the projects page
  def inject_ids(attribute)
    @filters.inject([]) { |array_of_ids, filter| array_of_ids = [] if array_of_ids.nil?; array_of_ids.push filter.try(attribute).id if filter.try(attribute).present? }
  end

  def fetch_filters
    filter_ids = params[:named_filter_id]
    @filters = filter_ids.present? ? NamedFilter.find(filter_ids) : NamedFilter.new
    #if this method  is being hit by clicking checkboxes on projects show page it will be an array
    #if not it will just be an instance of the NamedFilter class
    if @filters.class == Array
      @search = Document.search do |query|
        query.fulltext @filters.inject(nil) { |fulltext, filter_text| fulltext or filter_text.q }
        query.with(:published, true)
        query.with(:contributor_id, inject_ids('contributor')) if inject_ids('contributor')
        query.with(:region_ids, inject_ids('region')) if inject_ids('region') 
        query.with(:language_id, inject_ids('language')) if inject_ids('language')
        query.with(:document_type_id, inject_ids('document_type')) if inject_ids('document_type')
        query.with(:theme_ids, inject_ids('theme')) if inject_ids('theme')
        query.with(:topic_ids, inject_ids('topic')) if inject_ids('topic')
        query.with(:era_ids, inject_ids('era')) if inject_ids('era')
      end
       #temp workround since views expected only one NamedFilter
       @filters = @filters.last
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
      end
      #temp workround since views expected only one NamedFilter
      @filters = NamedFilter.new
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
