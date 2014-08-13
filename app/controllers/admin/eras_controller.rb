class Admin::ErasController < AdminController
  before_filter :ensure_editor!
  before_filter :fetch_era, only: [:edit, :update, :destroy]

  def index
    @eras = Era.hash_tree
  end

  def new
    @era = Era.new
  end

  def edit
  end

  def create
    @era = Era.new permitted_params
    if @era.save
      flash[:notice] = 'Era created successfully'
      redirect_to admin_eras_path
    else
      flash[:error] = @era.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    if @era.update permitted_params
      flash[:notice] = 'Era updated successfully'
      redirect_to admin_eras_path
    else
      flash[:error] = @era.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    if @era.destroy
      flash[:notice] = 'Era deleted successfully'
    else
      flash[:error] = 'An error occurred while trying to delete that era'
    end
    redirect_to admin_eras_path
  end

  protected

  def permitted_params
    params.require(:era).permit(:name, :parent_id, :start_year, :end_year)
  end

  def fetch_era
    @era = Era.find params[:id]
  end
end
