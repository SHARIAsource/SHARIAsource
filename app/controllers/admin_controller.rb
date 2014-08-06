class AdminController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :authenticate_user!

  protected

  def ensure_admin!
    redirect_to root_path unless current_user.is_admin?
  end

  def ensure_editor!
    redirect_to root_path unless current_user.is_editor?
  end

  def ensure_contributor!
    redirect_to root_path unless current_user.is_contributor?
  end
end
