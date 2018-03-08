require 'rails_helper'

RSpec.describe Admin::NamedFiltersController, type: :controller do

  before :each do
    @user =  create(:user)
    @user.is_admin = true
    @user.is_editor = true
    @user.accepted_terms = true
    @user.save!
    sign_in @user
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      named_filter = create(:named_filter)

      get :edit, params: {id: named_filter.id}
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

end
