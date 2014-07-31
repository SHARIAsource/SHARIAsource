class Admin::SourcesController < AdminController
  before_filter :ensure_editor!

  def index
    @sources = Source.all
  end

  def new
    @source = Source.new
  end

  def edit
    @source = Source.find params[:id]
  end

  def create
    @source = Source.new permitted_params
    if @source.save
      flash[:notice] = 'Source created successfully'
      redirect_to admin_sources_path
    else
      flash[:error] = @source.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    @source = Source.find params[:id]
    if @source.update permitted_params
      flash[:notice] = 'Source updated successfully'
      redirect_to admin_sources_path
    else
      flash[:error] = @source.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    @source = Source.find params[:id]
    if @source.destroy
      flash[:notice] = 'Source deleted successfully'
    else
      flash[:error] = 'An error occurred while trying to delete that topic'
    end
    redirect_to admin_sources_path
  end

  protected

  def permitted_params
    params.require(:source).permit(:title, :region_id, :document_type_id, :pdf,
                                   theme_ids: [], topic_ids: [], tag_ids: [],
                                   era_ids: [], pages_attributes: [ :id,
                                     body_attributes: [:id, :text, :language]
                                   ])
  end
end
