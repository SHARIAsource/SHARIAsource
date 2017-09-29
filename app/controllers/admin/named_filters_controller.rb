class Admin::NamedFiltersController < AdminController
  before_filter :fetch_filter, only: [:edit, :update, :destroy]

  def index
    @named_filters = NamedFilter.where({})
  end

  def create
    @named_filter = NamedFilter.new permitted_params
    if @named_filter.save
      flash[:notice] = 'New filter created successfully'
      redirect_to admin_named_filters_path
    else
      flash[:error] = @named_filter.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    if @named_filter.update permitted_params
      flash[:notice] = 'filter updated successfully'
      redirect_to admin_named_filters_path
    else
      flash[:error] = @named_filter.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    if @named_filter.destroy
      flash[:notice] = 'Named filter deleted successfully'
    else
      flash[:error] = 'An error occured while trying to delete that named_filter'
    end
    redirect_to admin_named_filters_path
  end

  def edit
  end

  def new
    @named_filter = NamedFilter.new
  end

  private

  def permitted_params
    params.require(:named_filter).permit(:name, :language_id, :user_id, :topic_id, :theme_id, :region_id, :era_id, :document_type_id, :project_id, :q, :date_from, :date_to, :date_format)
  end

  def fetch_filter
    @named_filter = NamedFilter.find params[:id]
  end
end
