module ApplicationHelper
  def admin_signed_in?
    user_signed_in? && current_user.is_admin?
  end

  def editor_signed_in?
    user_signed_in? && current_user.is_editor?
  end

  def contributor_signed_in?
    user_signed_in? && current_user.is_contributor?
  end
end
