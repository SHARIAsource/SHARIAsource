class SearchesController < ApplicationController
  def show
    @languages = Language.all
    @authors = User.all
    @topics = Topic.all
    @themes = Theme.all
    @regions = Region.hash_tree
    @eras = Era.hash_tree
    @document_types = DocumentType.hash_tree
  end
end
