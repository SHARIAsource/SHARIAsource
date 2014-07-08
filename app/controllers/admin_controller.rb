class AdminController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :authenticate_user!

  protected

  def permitted_update_params
    params.require(:user).permit(:is_editor, :is_contributor)
  end

  def ensure_admin!
    redirect_to root_path unless current_user.is_admin?
  end

  def ensure_editor!
    redirect_to root_path unless current_user.is_editor?
  end
end
