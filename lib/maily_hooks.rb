user = User.first
document = Document.first
suggestions = ['suggestion1', 'suggestion2']

Maily.hooks_for('EditorMailer') do |mailer|
  mailer.register_hook(:inactivity_email, user)
  mailer.register_hook(:tag_suggestion_email, document, suggestions)
  mailer.register_hook(:document_creation_email, document)
  mailer.register_hook(:document_published_email, document)
end
