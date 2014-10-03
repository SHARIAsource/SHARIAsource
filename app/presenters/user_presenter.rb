class UserPresenter < BasePresenter
  def name_with_collaborator
    [name, collaborator && collaborator.name].compact.join(', ')
  end
end
