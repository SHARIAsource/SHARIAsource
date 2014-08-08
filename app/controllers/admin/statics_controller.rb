class Admin::StaticsController < AdminController
  before_filter :ensure_editor!
  before_filter :fetch_static, only: [:edit, :update, :destroy]

  def index
    @statics = Static.all
  end

  def new
    @static = Static.new
  end

  def edit
  end

  def create
    @static = Static.new permitted_params
    if @static.save
      flash[:notice] = 'Static page created successfully'
      redirect_to admin_statics_path
    else
      flash[:error] = @static.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    if @static.update permitted_params
      flash[:notice] = 'Static page updated successfully'
      redirect_to admin_statics_path
    else
      flash[:error] = @static.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    if @static.destroy
      flash[:notice] = 'Static page deleted successfully'
    else
      flash[:error] = 'An error occurred while trying to delete that static page'
    end
    redirect_to admin_statics_path
  end

  protected

  def permitted_params
    params.require(:static).permit(:title, :slug, :body)
  end

  def fetch_static
    @static = Static.find params[:id]
  end
end
