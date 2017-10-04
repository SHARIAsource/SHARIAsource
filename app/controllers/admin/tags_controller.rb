class Admin::TagsController < AdminController
  before_action :ensure_editor!
  before_action :fetch_tag, only: [:edit, :update, :destroy]

  def index
    @tags = Tag.all
  end

  def new
    @tag = Tag.new
  end

  def edit
  end

  def create
    @tag = Tag.new permitted_params
    respond_to do |format|
      if @tag.save
        format.html { flash[:notice] = 'Tag created successfully'
                    redirect_to admin_tags_path
                    }
        format.js { render layout: false, action: 'create' }
      else
        format.html { flash[:error] = @tag.errors.full_messages.to_sentence
                    render :new
                    }
        format.js
      end
    end
  end

  def update
    if @tag.update permitted_params
      flash[:notice] = 'Tag updated successfully'
      redirect_to admin_tags_path
    else
      flash[:error] = @tag.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    if @tag.destroy
      flash[:notice] = 'Tag deleted successfully'
    else
      flash[:error] = 'An error occurred while trying to delete that tag'
    end
    redirect_to admin_tags_path
  end

  def sort
    type = Tag.find params[:tag_id]
    direction = params[:sort_order_position].to_sym
    type.update_attribute :sort_order_position, direction
    head :ok
  end

  def sort_date
    Tag.sort_by_dates

    respond_to do |format|
      format.js {render inline: "location.reload();" }
    end
  end

  def sort_name
    Tag.sort_by_names

    respond_to do |format|
      format.js {render inline: "location.reload();" }
    end
  end

  protected

  def permitted_params
    params.require(:tag).permit(:name)
  end

  def fetch_tag
    @tag = Tag.find params[:id]
  end
end
