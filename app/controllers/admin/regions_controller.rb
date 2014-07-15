class Admin::RegionsController < AdminController
  before_filter :ensure_editor!
  before_filter :fetch_region, only: [:edit, :update, :destroy]

  def index
    @regions = Region.hash_tree
  end

  def new
    @region = Region.new
  end

  def edit
  end

  def create
    @region = Region.new permitted_params
    if @region.save
      flash[:notice] = 'Region created successfully'
      redirect_to admin_regions_path
    else
      flash[:error] = @region.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    if @region.update permitted_params
      flash[:notice] = 'Region updated successfully'
      redirect_to admin_regions_path
    else
      flash[:error] = @region.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    if @region.destroy
      flash[:notice] = 'Region deleted successfully'
    else
      flash[:error] = 'An error occurred while trying to delete that region'
    end
    redirect_to admin_regions_path
  end

  protected

  def permitted_params
    params.require(:region).permit(:name, :parent_id)
  end

  def fetch_region
    @region = Region.find params[:id]
  end
end
