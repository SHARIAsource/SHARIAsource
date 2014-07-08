class Admin::UsersController < AdminController
  before_filter :ensure_admin!

  def index
    @users = User.order(:last_name_without_articles)
  end

  def update
    User.find(params[:id]).update_attributes(permitted_update_params)
    flash[:notice] = 'User roles updated successfully'
    redirect_to :back
  end
end
