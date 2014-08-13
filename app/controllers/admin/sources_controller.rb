class Admin::SourcesController < AdminController
  before_filter :ensure_contributor!
  before_filter :fetch_source, only: [:edit, :update, :destroy]

  def index
    @sources = Source.where id: @current_user.self_and_descendant_ids
  end

  def new
    @source = @current_user.sources.build
  end

  def edit
  end

  def create
    @source = @current_user.sources.build permitted_params
    if @source.save
      flash[:notice] = 'Source created successfully'
      redirect_to admin_sources_path
    else
      flash[:error] = @source.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    if @source.update permitted_params
      flash[:notice] = 'Source updated successfully'
      redirect_to admin_sources_path
    else
      flash[:error] = @source.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    if @source.destroy
      flash[:notice] = 'Source deleted successfully'
    else
      flash[:error] = 'An error occurred while trying to delete that source'
    end
    redirect_to admin_sources_path
  end

  protected

  def permitted_params
    whitelist = [:title, :volume_count, :document_type_id, :pdf, :language_id,
                 :gregorian_date_string, :lunar_hijri_date_string,
                 :source_name,:source_url, :author, :translators, :editors,
                 :publisher, :publisher_location, :alternate_titles,
                 :alternate_authors, region_ids: [], theme_ids: [],
                 topic_ids: [], tag_ids: [], era_ids: [], pages_attributes: [
                   :id, body_attributes: [:id, :text, :language]
                 ]]
    params.require(:source).permit(*whitelist)
  end

  def fetch_source
    @source = @current_user.sources.where(id: params[:id]).first
  end
end
