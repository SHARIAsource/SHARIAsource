module ApplicationHelper
  def admin_signed_in?
    user_signed_in? && current_user.is_admin?
  end
end
