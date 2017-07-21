class Admin::MiscsController < AdminController
  before_action :ensure_elevated!
  before_action :fetch_misc, only: [:edit, :update, :destroy]

  def index
    @miscs = Misc.all
  end

  def new
    @misc = Misc.new
  end

  def edit
  end

  def create
    @misc = Misc.new permitted_params.merge(attached_file_token: params[:authenticity_token])
    logger.ap @misc

    if @misc.save
      flash[:notice] = 'Misc. page created successfully'
      redirect_to admin_miscs_path
    else
      flash[:error] = @misc.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    if @misc.update permitted_params
      flash[:notice] = 'Misc. page updated successfully'
      redirect_to admin_miscs_path
    else
      flash[:error] = @misc.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    if @misc.destroy
      flash[:notice] = 'Misc. page deleted successfully'
    else
      flash[:error] = 'An error occurred while trying to delete that misc page'
    end
    redirect_to admin_miscs_path
  end

  protected

  def permitted_params
    params.require(:misc).permit(:title, :slug, :body)
  end

  def fetch_misc
    @misc = Misc.find params[:id]
  end
end
