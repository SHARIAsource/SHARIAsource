class TagSuggestionsController < ApplicationController
  def create
    document = Document.find params[:document_id]
    suggestions = params[:tag_suggestion][:tags].split(',').map(&:strip)
    EditorMailer.tag_suggestion_email(document, suggestions).deliver
    redirect_to document_path(params[:document_id])
  end
end
