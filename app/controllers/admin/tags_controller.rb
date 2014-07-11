class Admin::TagsController < AdminController
  before_filter :ensure_editor!
  before_filter :fetch_tag, only: [:edit, :update, :destroy]

  def index
    @tags = Tag.all
  end

  def new
    @tag = Tag.new
  end

  def edit
  end

  def create
    @tag = Tag.new permitted_params
    if @tag.save
      flash[:notice] = 'Tag created successfully'
      redirect_to admin_tags_path
    else
      flash[:error] = @tag.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    if @tag.update permitted_params
      flash[:notice] = 'Tag updated successfully'
      redirect_to admin_tags_path
    else
      flash[:error] = @tag.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    if @tag.destroy
      flash[:notice] = 'Tag deleted successfully'
    else
      flash[:error] = 'An error occurred while trying to delete that tag'
    end
    redirect_to admin_tags_path
  end

  protected

  def permitted_params
    params.require(:tag).permit(:name)
  end

  def fetch_tag
    @tag = Tag.find params[:id]
  end
end
