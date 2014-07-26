class Admin::StaticsController < AdminController
  before_filter :ensure_editor!

  def index
    @statics = Static.all
  end

  def new
    @static = Static.new
    @static.build_body
  end

  def edit
    @static = Static.includes(:body).find(params[:id])
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
    @static = Static.find params[:id]
    if @static.update permitted_params
      flash[:notice] = 'Static page updated successfully'
      redirect_to admin_statics_path
    else
      flash[:error] = @static.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    @static = Static.find params[:id]
    if @static.destroy
      flash[:notice] = 'Static page deleted successfully'
    else
      flash[:error] = 'An error occurred while trying to delete that static page'
    end
    redirect_to admin_statics_path
  end

  protected

  def permitted_params
    params.require(:static).permit(:title, :slug, body_attributes: [
      :text
    ])
  end
end
