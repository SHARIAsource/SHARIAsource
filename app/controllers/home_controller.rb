class HomeController < ApplicationController
  def index
    @home_presenter = HomePresenter.new
  end
end
