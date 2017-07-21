class Admin::UsersController < AdminController
  before_action :ensure_elevated!
  before_action :fetch_user, only: [:edit, :update, :destroy]

  def index
    if current_user.is_admin
      @users = User.all.order(:last_name_without_articles)
    else
      @users = current_user.descendants.order(:last_name_without_articles)
    end
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    random_pass = SecureRandom.urlsafe_base64(24)
    @user = User.new permitted_params
    @user.password = @user.password_confirmation = random_pass
    if @user.save
      flash[:notice] = 'Account created successfully'
      @user.send_reset_password_instructions
      redirect_to admin_users_path
    else
      flash[:error] = @user.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    if params[:user][:force_password_reset]
      @user.send_reset_password_instructions
    end
    if @user.update permitted_params
      flash[:notice] = 'Account updated successfully'
      redirect_to admin_users_path
    else
      flash[:error] = @user.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    if @user.destroy
      redirect_to admin_users_path, flash: {
        notice: 'Account deleted successfully'
      }
    else
      redirect_to admin_users_path, flash: {
        alert: @user.errors.full_messages.to_sentence
      }
    end
  end

  protected

  def permitted_params
    params.require(:user).permit(:is_editor, :requires_approval, :first_name,
                                 :last_name, :about, :avatar, :email,
                                 :collaborator_id, :parent_id, :disabled,
                                 :is_admin, :is_senior_scholar, :is_password_protector,
                                 :is_original_author)
  end

  def fetch_user
    @user = User.find params[:id]
    unless @user.ancestors.include?(current_user) || current_user.is_admin
      redirect_to admin_users_path
    end
  end
end
