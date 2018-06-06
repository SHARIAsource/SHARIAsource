class UserPresenter < BasePresenter
  def name_with_collaborator
    [name_with_status, collaborator && collaborator.name].compact.join(', ')
  end

  def name_with_status
    if is_senior_scholar
      "#{name}, Senior Scholar"
    else
      name
    end
  end
end
