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
    mail(
      to: user.email,
      subject: "ShariaSource activity reminder"
    )
  end

  def document_creation_email(document)
    names = [ document.translators, document.editors ].
      reduce(document.authors.select("trim(name) as name")) do |sum, scope|
        sum.union(scope.select("trim(name) as name"))
    end

    users = document.contributors.union(User.where("first_name || ' ' || last_name IN (?)", names.map(&:name))).uniq

    @document = document

    mail(
      to: users.map(&:email),
      subject: "Your contribution has been created on the SHARIAsource portal"
    )
  end
end
