class AuthorsController < ApplicationController
  def index
    @author_table = DocumentType.author_counts
  end

  def show
    @author = User.find params[:id]
    @filters = SearchFilters.new author: [params[:id]]
    @languages = Language.all
    @authors = User.all
    @topics = Topic.all
    @themes = Theme.all
    @regions = Region.hash_tree
    @eras = Era.hash_tree
    @document_types = DocumentType.hash_tree
    @search = Document.search do |query|
      query.with(:contributor_id, @filters.author)
    end
  end
end
