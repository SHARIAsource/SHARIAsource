class ContributorsController < ApplicationController
  def index
    @contributor_table = DocumentType.contributor_counts
  end

  def show
    @contributor = UserPresenter.new(User.find(params[:id]))
    @filters = SearchFilters.new contributor: [params[:id]]
    @filters.q = ''
    @languages = Language.rank(:sort_order)
    @contributors = User.joins(:documents).distinct
    @topics = Topic.all
    @themes = Theme.all
    @regions = Region.hash_tree
    @eras = Era.hash_tree
    @document_types = DocumentType.hash_tree
    @search = Document.search do |query|
      query.fulltext @filters.q
      query.with(:contributor_id, @filters.contributor)
    end
  end
end
