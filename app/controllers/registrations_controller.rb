class RegistrationsController < Devise::RegistrationsController
  layout 'admin'

  def index
    redirect_to :edit
  end

  private

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :password,
                                 :password_confirmation, :accepted_terms)
  end

  def account_update_params
    params.require(:user).permit(:email, :password, :password_confirmation,
                                 :current_password, :accepted_terms, :new_content_email)
  end
end
