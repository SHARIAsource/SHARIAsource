class Admin::DocumentsController < AdminController
  before_filter :fetch_document, only: [:edit, :update, :destroy]

  def index
    @documents = Document.unscoped.load.where(
      contributor_id: current_user.self_and_descendant_ids
    )
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
      redirect_to edit_admin_document_path(@document)
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
      redirect_to edit_admin_document_path(@document)
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
                 :gregorian_date_string, :lunar_hijri_date_string,
                 :source_name,:source_url, :author, :translators, :editors,
                 :publisher, :publisher_location, :alternate_titles,
                 :alternate_authors, :featured_position, :reference_type_id,
                 :permission_giver, region_ids: [], theme_ids: [],
                 topic_ids: [], tag_ids: [], referenced_document_ids: [],
                 era_ids: [], pages_attributes: [
                   :id, body_attributes: [:id, :text]
                 ], body_attributes: [:id, :text]]
    unless current_user.requires_approval?
      whitelist << :published
    end
    params.require(:document).permit(*whitelist)
  end

  def fetch_document
    @document = Document.unscoped.load.find params[:id]
    ids = current_user.self_and_descendant_ids
    unless ids.include? @document.contributor.id
      redirect_to admin_documents_path
    end
  end
end
