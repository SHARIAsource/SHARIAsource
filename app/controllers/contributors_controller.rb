class ContributorsController < ApplicationController
  def index
    @contributor_table = DocumentType.contributor_counts
    @misc_page = Misc.find_by(slug: "editors_and_contributors")
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
    @documents_as_editor_ids = Document.joins(:editors)
                                       .merge(Editor.where(name: @contributor.name))
                                       .map(&:id)
                                       .flatten

    @documents_as_author_refs_ids = Document.joins(:authors)
                                            .merge(Author.where(name: @contributor.name))
                                            .map(&:referenced_documents)
                                            .map(&:ids)
                                            .flatten
    @documents_as_author_ids = Document.joins(:authors)
                                       .merge(Author.where(name: @contributor.name))
                                       .map(&:id)
                                       .flatten
    @filters.q += " " + @contributor.author.name if @contributor.author.present?
    @search = Document.solr_search do |query|
      query.fulltext @filters.q
      query.with(:published, true)
      query.any_of do |querys|
        querys.with(:contributor_ids, @filters.contributor.first)
        querys.with(:id, @documents_as_editor_ids) if @documents_as_editor_ids.any?
        querys.with(:id, @documents_as_author_refs_ids) if @documents_as_author_refs_ids.any?
        querys.with(:id, @documents_as_author_ids) if @documents_as_author_ids.any?
      end
    end
  end
end
