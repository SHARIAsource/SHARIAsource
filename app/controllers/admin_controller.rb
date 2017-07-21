class AdminController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :verify_accepted_terms!

  protected

  def verify_accepted_terms!
    return true if current_user.accepted_terms?

    flash[:alert] = "Sorry, but you must read and accept the contributor terms before you can do that."
    redirect_to edit_user_registration_path
  end

  def ensure_elevated!
    redirect_to root_path unless current_user.is_editor? || current_user.is_admin?
  end

  def ensure_editor!
    redirect_to root_path unless current_user.is_editor?
  end

  def ensure_admin!
    redirect_to root_path unless current_user.is_admin?
  end
end
