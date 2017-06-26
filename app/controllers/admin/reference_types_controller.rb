class Admin::ReferenceTypesController < AdminController
  before_filter :ensure_editor!
  before_filter :fetch_reference_type, only: [:edit, :update, :destroy]

  def index
    @reference_types = ReferenceType.all
  end

  def new
    @reference_type = ReferenceType.new
    @reference_types = ReferenceType.all
  end

  def edit
    @reference_types = ReferenceType.all
  end

  def create
    @reference_type = ReferenceType.new permitted_params
    if @reference_type.save
      flash[:notice] = 'Reference Type created successfully'
      redirect_to admin_reference_types_path
    else
      flash[:error] = @reference_type.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    if @reference_type.update permitted_params
      flash[:notice] = 'Reference Type updated successfully'
      redirect_to admin_reference_types_path
    else
      flash[:error] = @reference_type.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    if @reference_type.destroy
      flash[:notice] = 'Reference Type deleted successfully'
    else
      flash[:error] = 'An error occurred while trying to delete that reference type'
    end
    redirect_to admin_reference_types_path
  end

  protected

  def permitted_params
    params.require(:reference_type).permit(:name)
  end

  def fetch_reference_type
    @reference_type = ReferenceType.find params[:id]
  end
end
