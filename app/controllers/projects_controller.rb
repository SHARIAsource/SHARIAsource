class ProjectsController < ApplicationController
  def show
    @project = Project.find params[:id]
    @filters = SearchFilters.new
    @languages = Language.rank(:sort_order)
    @filters.q = @project.search_string
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
      query.with(:contributor_id, @filters.contributor)
    end
  end
end
