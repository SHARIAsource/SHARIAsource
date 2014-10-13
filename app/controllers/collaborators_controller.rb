class CollaboratorsController < ApplicationController
  def index
    @collaborators = Collaborator.all
  end

  def show
    @collaborator = Collaborator.find params[:id]
  end
end
