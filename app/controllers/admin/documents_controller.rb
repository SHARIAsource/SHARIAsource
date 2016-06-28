class Admin::DocumentsController < AdminController
  before_filter :fetch_document, only: [:edit, :update, :destroy]
  before_filter :ensure_editor!, only: [:destroy]

  def unpublished
    if ( current_user.is_editor && current_user.is_admin )
      @documents = Document.all
    else
      @documents = Document.where(
        contributor_id: current_user.self_and_descendant_ids
      )
    end

    @unpublished_documents = @documents.where(published: 'false')
    respond_to do |format|
      format.html
      format.json { render json: DocumentsDatatable.new(view_context, false) }
    end
  end

  def published

    if ( current_user.is_editor && current_user.is_admin )
      @documents = Document.all
    else
      @documents = Document.where(
        contributor_id: current_user.self_and_descendant_ids
      )
    end

    @published_documents = @documents.where(published: 'true')
    respond_to do |format|
      format.html
      format.json { render json: DocumentsDatatable.new(view_context, true) }
    end
  end

  def new
    @document = current_user.documents.build
    @document.build_body
  end

  def edit
    unless @document.processed
      redirect_to unpublished_admin_documents_path
    end
  end

  def create
    @document = current_user.documents.build permitted_params
    if @document.save
      flash[:notice] = 'Document created successfully'
      if params[:create_and_continue]
        redirect_to new_admin_document_path
      elsif params[:create_and_edit]
        redirect_to edit_admin_document_path @document
      else
        redirect_to unpublished_admin_documents_path
      end
    else
      flash[:error] = @document.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    prev_state = @document.published
    if @document.update permitted_params
      flash[:notice] = 'Document updated successfully'
      if current_user.requires_approval?
        @document.update! published: false
      end
      @document.index!
      DocumentTypeCountWorker.perform_async
      if params[:create_and_continue]
        redirect_to new_admin_document_path
      elsif params[:create_and_edit]
        redirect_to edit_admin_document_path @document
      else
        # if we unpublish a document, we want to stay on the
        # unpublished view so that we can unpublish another if needed
        if @document.published != prev_state
          if @document.published
            redirect_to unpublished_admin_documents_path
          else
            redirect_to published_admin_documents_path
          end
        else
          redirect_to published_admin_documents_path
        end
      end
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
    redirect_to published_admin_documents_path
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
                   :id, body_attributes: [:id, :text, :hybrid_text]
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
      if @document.published
        redirect_to published_admin_documents_path
      else
        redirect_to unpublished_admin_documents_path
      end
    end
  end
end
