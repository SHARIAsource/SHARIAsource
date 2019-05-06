class MiscController < ApplicationController
  def show
    begin
      @misc = Misc.find_by_slug!(params[:slug])
    rescue ActiveRecord::RecordNotFound
      redirect_to root_url
    end
  end
end
