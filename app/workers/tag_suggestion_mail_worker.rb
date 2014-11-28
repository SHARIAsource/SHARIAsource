# This is not being used currently to get around workers
# not reading ENV variables used to set host option in
# mailer template renderings.
class TagSuggestionMailWorker
  include Sidekiq::Worker

  def perform(document_id, tags)
    suggestions = tags.split ', '
    document = Document.find document_id
    EditorMailer.tag_suggestion_email(document, suggestions).deliver
  end
end
