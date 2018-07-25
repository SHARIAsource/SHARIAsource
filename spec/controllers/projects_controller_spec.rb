require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  include Devise::Test::ControllerHelpers

  describe "GET #show" do
    it "returns http success" do
      project = create(:project)
      user = create(:user)

      project.users << user

      sign_in user

      get :show, params: {id: project.id }
      expect(response).to have_http_status(:success)
    end
  end

end
