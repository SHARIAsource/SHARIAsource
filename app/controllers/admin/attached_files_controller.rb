class Admin::AttachedFilesController < AdminController

  # TODO: Change this to verify they are contributors and logged in
  before_filter :ensure_editor!
  before_filter :set_attachable, only: [:create]

  def create
    file_params = {
      token: params[:token],
      file: params[:file],
      user: current_user,
    }
    AttachedFile.create!(file_params)

    # This assigns the newly created AttachedFile, and any AttachedFiles previously created
    #   with this token, to the attachable. This approach works for both new and persisted
    #   attachables. When adding a new AttachedFile to a persisted attachable that already
    #   has AttachedFiles, it doesn't need to touch the existing AttachedFiles.
    if params[:token]
      @attachable.attached_files << AttachedFile.where(token: params[:token])
    end

    render partial: 'admin/shared/attached_files_list', locals: {attachable: @attachable}
  end

  protected

  def set_attachable
    attachable_type = params[:type]
    id = params[:id]

    if attachable_type && !AttachedFile.registered_attachable?(attachable_type)
      raise "Unregistered attachable_type: '#{attachable_type}' You'll need to register that class name in AttachedFile."
    end

    if id && attachable_type
      @attachable = AttachedFile.find_attachable(id: id, type: attachable_type)
      # TODO: Verify current_user has rights to this @attachable
    elsif params[:token]
      @attachable = attachable_type.constantize.new
      @attachable.attached_files << AttachedFile.where(token: params[:token])
    else
      raise "Token or type required to find attachable object"
    end
  end

  def permitted_params
    params.require(:document_type).permit(:name, :parent_id, :sort_order)
  end

end
