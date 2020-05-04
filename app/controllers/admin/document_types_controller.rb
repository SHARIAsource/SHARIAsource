class Admin::DocumentTypesController < AdminController
  include ActionView::Helpers::UrlHelper

  before_action :ensure_editor!
  before_action :fetch_document_type, only: [:edit, :update, :destroy]

  def index
    @document_types = DocumentType.hash_tree
  end

  def new
    @document_type = DocumentType.new
  end

  def edit
  end

  def create
    @document_type = DocumentType.new permitted_params
    if @document_type.save
      flash[:notice] = 'Document Type created successfully'
      redirect_to admin_document_types_path
    else
      flash[:error] = @document_type.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    if @document_type.update permitted_params
      flash[:notice] = 'Document Type updated successfully'
      redirect_to admin_document_types_path
    else
      flash[:error] = @document_type.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    if @document_type.documents.count == 0
      if @document_type.destroy
        flash[:notice] = 'Document Type deleted successfully'
      else
        flash[:error] = @document_type.errors.full_messages.join(", ")
      end
    else
      links = @document_type.documents.first(3).map do |document|
        link_to document.name, edit_admin_document_path(document)
      end
      flash[:error] = "Cannot delete this document type as there are documents linked: <br />#{links.join("&nbsp;|&nbsp;")}"

      if @document_type.documents.count > links.count
        flash[:error] += " (+ #{@document_type.documents.count - links.count} other)"
      end
    end

    redirect_to admin_document_types_path
  end

  def sort
    type = DocumentType.find params[:document_type_id]
    direction = params[:sort_order_position].to_sym
    type.update_attribute :sort_order_position, direction

    respond_to do |format|
      format.js {render inline: "location.reload();" }
    end
  end

  def sort_name
    DocumentType.sort_by_names params[:item_id]

    respond_to do |format|
      format.js {render inline: "location.reload();" }
    end
  end

  protected

  def permitted_params
    params.require(:document_type).permit(:name, :parent_id, :sort_order)
  end

  def fetch_document_type
    @document_type = DocumentType.find params[:id]
  end
end
