class Admin::CommentariesController < AdminController
  before_filter :ensure_contributor!
  before_filter :fetch_commentary

  def index
    @commentaries = Commentary.where(
      contributor_id: @current_user.self_and_descendant_ids
    )
  end

  def new
    @commentary = @current_user.commentaries.build
    @commentary.build_body
  end

  def edit
  end

  def create
    @commentary = @current_user.commentaries.build permitted_params
    if @commentary.save
      flash[:notice] = 'Commentary created successfully'
      redirect_to admin_commentaries_path
    else
      flash[:error] = @commentaries.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    if @commentary.update permitted_params
      flash[:notice] = 'Commentary updated successfully'
      redirect_to admin_commentaries_path
    else
      flash[:error] = @commentary.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    if @commentary.destroy
      flash[:notice] = 'Commentary deleted successfully'
    else
      flash[:error] = 'An error occurred while trying to delete that commentary'
    end
    redirect_to admin_commentaries_path
  end

  protected

  def permitted_params
    params.require(:commentary).permit(:title, body_attributes: [:id, :text])
  end

  def fetch_commentary
    @commentary = @current_user.commentaries.where(id: params[:id]).first
  end
end
