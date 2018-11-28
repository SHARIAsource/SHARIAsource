class EditorMailer < ActionMailer::Base
  def tag_suggestion_email(document, suggestions)
    @document = document
    @suggestions = suggestions

    mail(
      to: document.contributor.email,
      subject: "Tag Suggestions for #{document.title}",
      cc: document.contributor.ancestors.pluck(:email)
    )
  end

  def inactivity_email(user)
    @user

    mail(
      to: user.email,
      subject: "ShariaSource activity reminder"
    )
  end
end
