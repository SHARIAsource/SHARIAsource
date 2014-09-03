class AdminController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :authenticate_user!

  protected

  def ensure_editor!
    redirect_to root_path unless current_user.is_editor?
  end
end
