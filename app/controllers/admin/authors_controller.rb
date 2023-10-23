class Admin::AuthorsController < AdminController
  before_action :ensure_elevated!
  before_action :fetch_author, only: [:edit, :update, :destroy]
  # before_action :set_author, only: [:edit, :update, :destroy]


  def index
    # @authors = Author.rank(:sort_order).all
    @authors = Author.all
  end

  def new
    @author = Author.new
  end

  def edit
    @author = Author.find(params[:id])
  end

  def create
    @author = Author.new permitted_params
    @author.sort_order_position = :last
    if @author.save
      flash[:notice] = 'New Author created successfully'
      redirect_to admin_authors_path
    else
      flash[:error] = @author.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    if @author.update permitted_params
      flash[:notice] = 'Author updated successfully'
      redirect_to admin_authors_path
    else
      flash[:error] = @author.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    if @author.destroy
      flash[:notice] = 'Author deleted successfully'
    else
      flash[:error] = 'An error occured while trying to delete that Author'
    end
    redirect_to admin_authors_path
  end

  def sort
    author = Author.find params[:id]
    direction = params[:sort_order_position].to_sym
    author.update_attribute :sort_order_position, direction
    head :ok
  end

  def sort_name
    Author.sort_by_names

    respond_to do |format|
      format.js {render inline: "location.reload();" }
    end
  end

  protected

  def permitted_params
    params.require(:author).permit(:name, :cnc_metadata_id, :user_id, :cnc_metadata_jsonb)
  end

  def fetch_author
    @author = Author.find params[:id]
  end
end
