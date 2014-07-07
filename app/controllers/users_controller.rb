class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :ensure_admin!

  def index
    @users = User.order(:last_name_without_articles)
  end

  def update
    User.find(params[:id]).update_attributes(permitted_update_params)
    flash[:notice] = 'User roles updated successfully'
    redirect_to :back
  end

  private

  def permitted_update_params
    params.require(:user).permit(:is_editor, :is_contributor)
  end

  def ensure_admin!
    redirect_to root_path unless current_user.is_admin?
  end
end
