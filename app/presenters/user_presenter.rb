class UserPresenter < BasePresenter

  def name_with_collaborator
    # [name_with_status, collaborator && collaborator.name].compact.join(', ')
    [name_with_role_and_status, collaborator && collaborator.name].compact.join(', ')
  end

  def name_with_status
    if is_senior_scholar
      "#{name}, Senior Scholar"
    else
      name
    end
  end

  def name_with_role_and_status
    if is_senior_scholar
      "#{name_with_role}, Senior Scholar"
    else
      name_with_role
    end
  end
end
