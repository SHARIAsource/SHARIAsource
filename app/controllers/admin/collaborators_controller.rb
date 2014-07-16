class Admin::CollaboratorsController < AdminController
  before_filter :ensure_editor!
  before_filter :fetch_collaborator, only: [:edit, :update, :destroy]

  def index
    @collaborators = Collaborator.all
  end

  def new
    @collaborator = Collaborator.new
  end

  def edit
  end

  def create
    @collaborator = Collaborator.new permitted_params
    if @collaborator.save
      flash[:notice] = 'New collaborator created successfully'
      redirect_to admin_collaborators_path
    else
      flash[:error] = @collaborator.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    if @collaborator.update permitted_params
      flash[:notice] = 'Collaborator updated successfully'
      redirect_to admin_collaborators_path
    else
      flash[:error] = @collaborator.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    if @collaborator.destroy
      flash[:notice] = 'Collaborator deleted successfully'
    else
      flash[:error] = 'An error occured while trying to delete that collaborator'
    end
    redirect_to admin_collaborators_path
  end

  protected

  def permitted_params
    params.require(:collaborator).permit(:name, :url, :description)
  end

  def fetch_collaborator
    @collaborator = Collaborator.find params[:id]
  end
end
