class CollaboratorsController < ApplicationController
  def index
    @collaborators = Collaborator.all
  end

  def show
  end
end
