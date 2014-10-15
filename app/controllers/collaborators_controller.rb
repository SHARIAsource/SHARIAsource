class CollaboratorsController < ApplicationController
  def index
    @collaborators = Collaborator.rank(:sort_order).all
  end

  def show
    @collaborator = Collaborator.find params[:id]
  end
end
