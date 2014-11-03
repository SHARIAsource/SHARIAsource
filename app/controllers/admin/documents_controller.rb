class Admin::DocumentsController < AdminController
  before_filter :fetch_document, only: [:edit, :update, :destroy]
  before_filter :ensure_editor!, only: [:destroy]

  def index
    if current_user.is_editor
      @documents = Document.latest
    else
      @documents = Document.latest.where(
        contributor_id: current_user.self_and_descendant_ids
      )
    end
  end

  def new
    @document = current_user.documents.build
    @document.build_body
  end

  def edit
    unless @document.processed
      redirect_to admin_documents_path
    end
  end

  def create
    @document = current_user.documents.build permitted_params
    if @document.save
      flash[:notice] = 'Document created successfully'
      redirect_to admin_documents_path
    else
      flash[:error] = @document.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    if @document.update permitted_params
      flash[:notice] = 'Document updated successfully'
      if current_user.requires_approval?
        @document.update! published: false
      end
      @document.index!
      DocumentTypeCountWorker.perform_async
      redirect_to admin_documents_path
    else
      flash[:error] = @document.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    if @document.destroy
      flash[:notice] = 'Document deleted successfully'
    else
      flash[:error] = 'An error occurred while trying to delete that Document'
    end
    redirect_to admin_documents_path
  end

  protected

  def permitted_params
    whitelist = [:title, :volume_count, :document_type_id, :pdf, :language_id,
                 :gregorian_year, :gregorian_month, :gregorian_day,
                 :source_name, :source_url, :author, :translators, :editors,
                 :publisher, :publisher_location, :alternate_titles,
                 :alternate_authors, :featured_position, :reference_type_id,
                 :permission_giver, :document_style, :summary, :citation,
                 region_ids: [], theme_ids: [], topic_ids: [], tag_ids: [],
                 referenced_document_ids: [], era_ids: [],
                 body_attributes: [:id, :text], pages_attributes: [
                   :id, body_attributes: [:id, :text]
                 ]]
    if current_user.is_editor
      whitelist << :contributor_id
    end
    unless current_user.requires_approval?
      whitelist << :published
    end
    params.require(:document).permit(*whitelist)
  end

  def fetch_document
    @document = Document.find params[:id]
    ids = current_user.self_and_descendant_ids
    unless current_user.is_editor || ids.include?(@document.contributor.id)
      redirect_to admin_documents_path
    end
  end
end
