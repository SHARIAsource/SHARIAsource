class TagSuggestionsController < ApplicationController
  def create
    TagSuggestionMailWorker.perform_async(params[:document_id],
                                          params[:tag_suggestion][:tags])
    redirect_to document_path(params[:document_id])
  end
end
