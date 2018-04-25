require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do

  describe "GET #show" do
    it "returns http success" do
      project = create(:project)

      get :show, params: {id: project.id }
      expect(response).to have_http_status(:success)
    end
  end

end
