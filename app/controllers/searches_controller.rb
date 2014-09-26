class SearchesController < ApplicationController
  def show
    filters = SearchFilters.new permitted_params
    @languages = Language.all
    @authors = User.all
    @topics = Topic.all
    @themes = Theme.all
    @regions = Region.hash_tree
    @eras = Era.hash_tree
    @document_types = DocumentType.hash_tree
    @search = Document.search do
      fulltext permitted_params[:q]
      with(:published, true)
      with(:topic_ids, filters.topic) if filters.topic
      with(:theme_ids, filters.theme) if filters.theme
      with(:language_id, filters.language) if filters.language
      with(:contributor_id, filters.author) if filters.author
      with(:region_ids, filters.region) if filters.region
      with(:era_ids, filters.era) if filters.era
      with(:document_type_id, filters.document_type) if filters.document_type
    end
    @filters = filters
  end

  def permitted_params
    params.permit(:q, :date_from, :date_to, :date_format, document_type: [],
                  language: [], author: [], topic: [], theme: [], region: [],
                  era: [])
  end
end
