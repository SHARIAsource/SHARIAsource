class SearchesController < ApplicationController
  def show
    @languages = Language.all
    @authors = User.all
    @topics = Topic.all
    @themes = Theme.all
    @regions = Region.hash_tree
    @eras = Era.hash_tree
    @document_types = DocumentType.hash_tree
    @params = permitted_params
    @search = Document.search do
      fulltext permitted_params[:q]
    end
  end

  def permitted_params
    params.permit(:q)
  end
end
