class Admin::NamedFiltersController < AdminController
  before_action :fetch_filter, only: [:edit, :update, :destroy]

  def index
    @named_filters = NamedFilter.where({})
  end

  def create
    if permitted_params[:quick_create_url].present?
      quick_create_url(permitted_params[:quick_create_url]) 
    else
      @named_filter = NamedFilter.new permitted_params
    end
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
    params.require(:named_filter).permit(:name, :priority, :language_id, :user_id, :topic_id, :theme_id, :region_id, :era_id, :document_type_id, :project_id, :q, :date_from, :date_to, :date_format, :quick_create_url, :parent_id, named_filter_document_ids: [], named_filter_additional_document_ids: [], named_filter_excluded_document_ids: [])
  end

  def fetch_filter
    @named_filter = NamedFilter.find params[:id]
  end

  def quick_create_url(url)
    query_string = Rack::Utils.parse_nested_query URI(url).query

    named_filter_values = { name: permitted_params[:name],
                            language_id: (query_string["language"][0] if query_string["language"]),
                            user_id: (query_string["user"][0] if query_string["user"]),
                            topic_id: (query_string["topic"][0] if query_string["topic"]),
                            theme_id:  (query_string["theme"][0] if query_string["theme"]),
                            region_id:  (query_string["region"][0] if query_string["region"]),
                            era_id:  (query_string["era"][0] if query_string["era"]),
                            document_type_id:  (query_string["document_type"][0] if query_string["document_type"]),
                            project_id: (permitted_params[:project_id] if query_string["project_id"]),
                            q:  (query_string["q"]if query_string["q"]),
                            date_from:  (query_string["date_from"] if query_string["date_from"]),
                            date_to: (query_string["date_to"]  if query_string["date_to"]),
                            date_format: (query_string["date_format"][0] if query_string["date_format"])
                          }
    @named_filter = NamedFilter.new named_filter_values
  end
end
