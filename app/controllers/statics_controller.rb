class StaticsController < ApplicationController
  def show
    @static = Static.find_by_slug!(params[:slug])
  end
end
