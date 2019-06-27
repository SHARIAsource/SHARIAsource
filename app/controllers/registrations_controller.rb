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

  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource_updated = update_resource(resource, account_update_params)
    yield resource if block_given?
    if resource_updated
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
          :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      bypass_sign_in resource, scope: resource_name
      respond_with resource, location: after_update_path_for(resource)
    else
      clean_up_passwords resource
      set_minimum_password_length
      flash[:error] = resource.errors.full_messages.to_sentence
      redirect_to '/users/edit'
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :password,
                                 :password_confirmation, :accepted_terms)
  end

  def account_update_params
    params.require(:user).permit(:email, :password, :password_confirmation,
                                 :current_password, :accepted_terms)
  end
end
