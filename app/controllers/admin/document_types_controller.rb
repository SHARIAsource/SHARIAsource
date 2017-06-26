class Admin::DocumentTypesController < AdminController
  before_filter :ensure_editor!
  before_filter :fetch_document_type, only: [:edit, :update, :destroy]

  def index
    @document_types = DocumentType.hash_tree
  end

  def new
    @document_type = DocumentType.new
    @document_types = DocumentType.hash_tree
  end

  def edit
    @document_types = DocumentType.hash_tree
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
    if @document_type.destroy
      flash[:notice] = 'Document Type deleted successfully'
    else
      flash[:error] = 'An error occurred while trying to delete that document type'
    end
    redirect_to admin_document_types_path
  end

  protected

  def permitted_params
    params.require(:document_type).permit(:name, :parent_id, :sort_order)
  end

  def fetch_document_type
    @document_type = DocumentType.find params[:id]
  end
end
