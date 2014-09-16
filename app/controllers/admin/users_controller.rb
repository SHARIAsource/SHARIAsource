class Admin::UsersController < AdminController
  before_filter :ensure_editor!

  def index
    @users = User.order(:last_name_without_articles)
  end

  def edit
    @user = User.find params[:id]
  end

  def update
    User.find(params[:id]).update permitted_params
    flash[:notice] = 'User roles updated successfully'
    redirect_to admin_users_path
  end

  protected

  def permitted_params
    params.require(:user).permit(:is_editor, :requires_approval, :first_name,
                                 :last_name, :about, :avatar,
                                 :collaborator_id, :parent_id)
  end
end
