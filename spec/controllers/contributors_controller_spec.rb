require 'rails_helper'
require 'securerandom'

RSpec.describe ContributorsController, type: :controller do
  render_views

  include Devise::Test::ControllerHelpers

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "includes a misc page content when one exists" do
      body = SecureRandom.uuid

      create :misc,
        slug: 'editors_and_contributors',
        title: 'Contributors',
        body: body

      get :index
      expect(response.body).to include(body)
    end
  end

end

