class Admin::ProjectsController < AdminController
  before_filter :fetch_project, only: [:edit, :update, :destroy]

  def index
    @projects = Project.where({})
  end

  def edit
  end

  def create
    @project = Project.new permitted_params
    if @project.save
      flash[:notice] = 'New project created successfully'
      redirect_to admin_projects_path
    else
      flash[:error] = @project.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    if @project.update permitted_params
      flash[:notice] = 'Project updated successfully'
      redirect_to admin_projects_path
    else
      flash[:error] = @project.errors.full_messages.to_sentence
      render :edit
    end
  end

  def new
    @project = Project.new
  end

  def destroy
    if @project.destroy
      flash[:notice] = 'Project deleted successfully'
    else
      flash[:error] = 'An error occured while trying to delete that project'
    end
    redirect_to admin_projects_path
  end

  private

  def permitted_params
    params.require(:project).permit(:name, :description, :photo, :projects_users_attributes => [:id, :sort_order, :user_id, :project_id], user_ids: [])
  end

  def fetch_project
    @project = Project.find params[:id]
  end
end
