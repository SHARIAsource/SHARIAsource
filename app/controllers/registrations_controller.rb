class RegistrationsController < Devise::RegistrationsController
  layout 'admin'

  #def new
    # Registrations created by admin
    #raise ActionController::RoutingError.new('Not Found')
  #end

  #def create
    # Registrations created by admin
    # raise ActionController::RoutingError.new('Not Found')
  #end

  #def destroy
    # Disable account deletion until we decide how to reallocate owned items
  #  redirect_to root_path
  #end

  private

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :password,
                                 :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:email, :password, :password_confirmation,
                                 :current_password)
  end
end
