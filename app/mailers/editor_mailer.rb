class EditorMailer < ActionMailer::Base
  def tag_suggestion_email(document, suggestions)
    @document = document
    @suggestions = suggestions
    User.editors.each do |editor|
      mail(to: editor.email, subject: "Tag Suggestions for #{document.title}")
    end
  end
end
