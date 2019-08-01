class UsersController < ApplicationController
  def index
    redirect_to edit_user_registration_url
  end
end
