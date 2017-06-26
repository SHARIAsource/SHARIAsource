class Admin::ThemesController < AdminController
  before_action :ensure_editor!
  before_action :fetch_theme, only: [:edit, :update, :destroy]

  def index
    @themes = Theme.all
  end

  def new
    @theme = Theme.new
    @themes = Theme.all
  end

  def edit
    @themes = Theme.all
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

  def sort
    type = Theme.find params[:tag_id]
    direction = params[:sort_order_position].to_sym
    type.update_attribute :sort_order_position, direction
    head :ok
  end

  def sort_date
    Theme.sort_by_dates

    respond_to do |format|
      format.js {render inline: "location.reload();" }
    end
  end

  def sort_name
    Theme.sort_by_names

    respond_to do |format|
      format.js {render inline: "location.reload();" }
    end
  end

  protected

  def permitted_params
    params.require(:theme).permit(:name, :archived)
  end

  def fetch_theme
    @theme = Theme.find params[:id]
  end
end
