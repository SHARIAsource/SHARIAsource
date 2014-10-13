class MiscController < ApplicationController
  def show
    @misc = Misc.find_by_slug!(params[:slug])
  end
end
