class Admin::EditorImagesController < AdminController
  before_filter :ensure_editor!
  before_filter :fetch_image, only: [:destroy]

  def index
    @editor_images = EditorImage.all
    respond_to do |format|
      format.html { render :index }
      format.json { render json: @editor_images }
    end
  end

  def new
    @editor_image = EditorImage.new
  end

  def create
    @editor_image = EditorImage.new permitted_params
    if @editor_image.save
      flash[:notice] = 'New image created successfully'
      redirect_to admin_editor_images_path
    else
      flash[:error] = @editor_image.errors.full_messages.to_sentence
      render :new
    end
  end

  def destroy
    if @editor_image.destroy
      flash[:notice] = 'Image deleted successfully'
    else
      flash[:error] = 'An error occured while trying to delete that image'
    end
    redirect_to admin_editor_images_path
  end

  protected

  def fetch_image
    @editor_image = EditorImage.find params[:id]
  end

  def permitted_params
    params.require(:editor_image).permit(:name, :image)
  end
end
