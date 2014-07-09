class Admin::ThemesController < AdminController
  before_filter :ensure_editor!
  before_filter :fetch_theme, only: [:edit, :update, :destroy]

  def index
    @themes = Theme.all
  end

  def new
    @theme = Theme.new
  end

  def edit
  end

  def create
    @theme = Theme.new permitted_params
    if @theme.save
      flash[:notice] = 'Theme created successfully'
      redirect_to admin_themes_path
    else
      flash[:error] = @theme.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    if @theme.update permitted_params
      flash[:notice] = 'Theme updated successfully'
      redirect_to admin_themes_path
    else
      flash[:error] = @theme.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    if @theme.destroy
      flash[:notice] = 'Theme deleted successfully'
    else
      flash[:error] = 'An error occurred while trying to delete that theme'
    end
    redirect_to admin_themes_path
  end

  protected

  def permitted_params
    params.require(:theme).permit(:name)
  end

  def fetch_theme
    @theme = Theme.find params[:id]
  end
end
