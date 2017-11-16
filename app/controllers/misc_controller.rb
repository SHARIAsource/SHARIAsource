class MiscController < ApplicationController
  def show
    begin
      @misc = Misc.find_by_slug!(params[:slug])
    rescue ActiveRecord::RecordNotFound
      render :text => "That Misc. Page doesn't exist or has moved. Check Misc. Pages", :status => "404"
    end
  end
end
