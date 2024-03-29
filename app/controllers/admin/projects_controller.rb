class Admin::ProjectsController < AdminController
  before_action :fetch_project, only: [:edit, :update, :destroy]

  def index
    @projects = Project.where({})
  end

  def edit
  end

  def create
    @project = Project.new permitted_params
    begin
      if @project.save
        flash[:notice] = 'New project created successfully'
        redirect_to edit_admin_project_path @project
      else
        flash[:error] = @project.errors.full_messages.to_sentence
        render :new
      end
    rescue ActiveRecord::RecordNotUnique
      flash[:error] = "Project slug should be unique"
      render :new
    end
  end

  def update
    begin
      if @project.update_attributes permitted_params
        redirect_to edit_admin_project_path @project, notice: 'Project updated successfully'
      else
        flash[:error] = @project.errors.full_messages.to_sentence
        render :edit
      end
    rescue PG::UniqueViolation
      flash[:error] = "Project slug should be unique"
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
    params.require(:project).permit(:name, :slug, :description, :attribution, :photo, :scale_photo, :featured_position, :published, :projects_users_attributes => [:id, :sort_order, :user_id, :project_id, :project_role, :external_collaborator], user_ids: [])
  end

  def fetch_project
    @project = Project.friendly.find params[:id]
  end
end
