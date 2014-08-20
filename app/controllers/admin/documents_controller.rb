class Admin::DocumentsController < AdminController
  before_filter :ensure_contributor!
  before_filter :fetch_document, only: [:edit, :update, :destroy]

  def index
    @documents = Document.where(
      contributor_id: @current_user.self_and_descendant_ids
    )
  end

  def new
    @document = @current_user.documents.build
    @document.build_body
  end

  def edit
    puts admin_document_path(@document)
  end

  def create
    @document = @current_user.documents.build permitted_params
    if @document.save
      flash[:notice] = 'Document created successfully'
      redirect_to admin_documents_path
    else
      flash[:error] = @doucment.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    if @document.update permitted_params
      flash[:notice] = 'Document updated successfully'
      redirect_to admin_documents_path
    else
      flash[:error] = @document.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    if @document.destroy
      flash[:notice] = 'Doucment deleted successfully'
    else
      flash[:error] = 'An error occurred while trying to delete that Document'
    end
    redirect_to admin_documents_path
  end

  protected

  def permitted_params
    whitelist = [:title, :volume_count, :document_type_id, :pdf, :language_id,
                 :gregorian_date_string, :lunar_hijri_date_string,
                 :source_name,:source_url, :author, :translators, :editors,
                 :publisher, :publisher_location, :alternate_titles,
                 :alternate_authors, :featured_position, region_ids: [],
                 theme_ids: [], topic_ids: [], tag_ids: [],
                 referenced_document_ids: [], era_ids: [], pages_attributes: [
                   :id, body_attributes: [:id, :text]
                 ], body_attributes: [:id, :text]]
    params.require(:document).permit(*whitelist)
  end

  def fetch_document
    @document = @current_user.documents.where(id: params[:id]).first
  end
end
