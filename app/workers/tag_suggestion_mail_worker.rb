class TagSuggestionMailWorker
  include Sidekiq::Worker

  def perform(document_id, tags)
    suggestions = tags.split ', '
    document = Document.find document_id
    EditorMailer.tag_suggestion_email(document, suggestions).deliver
  end
end
