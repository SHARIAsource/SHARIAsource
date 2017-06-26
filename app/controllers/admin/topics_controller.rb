class Admin::TopicsController < AdminController
  before_action :ensure_editor!
  before_action :fetch_topic, only: [:edit, :update, :destroy]

  def index
    @topics = Topic.all
  end

  def new
    @topic = Topic.new
    @topics = Topic.all
  end

  def edit
    @topics = Topic.all
  end

  def create
    @topic = Topic.new permitted_params
    if @topic.save
      flash[:notice] = 'Topic created successfully'
      redirect_to admin_topics_path
    else
      flash[:error] = @topic.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    if @topic.update permitted_params
      flash[:notice] = 'Topic updated successfully'
      redirect_to admin_topics_path
    else
      flash[:error] = @topic.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    if @topic.destroy
      flash[:notice] = 'Topic deleted successfully'
    else
      flash[:error] = 'An error occurred while trying to delete that topic'
    end
    redirect_to admin_topics_path
  end

  def sort
    type = Topic.find params[:tag_id]
    direction = params[:sort_order_position].to_sym
    type.update_attribute :sort_order_position, direction
    head :ok
  end

  def sort_date
    Topic.sort_by_dates

    respond_to do |format|
      format.js {render inline: "location.reload();" }
    end
  end

  def sort_name
    Topic.sort_by_names

    respond_to do |format|
      format.js {render inline: "location.reload();" }
    end
  end

  protected

  def permitted_params
    params.require(:topic).permit(:name)
  end

  def fetch_topic
    @topic = Topic.find params[:id]
  end
end
