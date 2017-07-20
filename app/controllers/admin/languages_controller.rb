class Admin::LanguagesController < AdminController
  before_filter :ensure_editor!
  before_filter :fetch_language, only: [:edit, :update, :destroy]

  def index
    @languages = Language.rank(:sort_order)
  end

  def new
    @language = Language.new
    @languages = Language.order(:name)
  end

  def edit
    @languages = Language.order(:name)
  end

  def create
    @language = Language.new permitted_params
    @language.sort_order_position = :last
    if @language.save
      flash[:notice] = 'Language created successfully'
      redirect_to admin_languages_path
    else
      flash[:error] = @language.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    if @language.update permitted_params
      flash[:notice] = 'Language updated successfully'
      redirect_to admin_languages_path
    else
      flash[:error] = @language.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    if @language.destroy
      flash[:notice] = 'Language deleted successfully'
    else
      flash[:error] = 'An error occurred while trying to delete that language'
    end
    redirect_to admin_languages_path
  end

  def sort
    language = Language.find params[:language_id]
    direction = params[:sort_order_position].to_sym
    language.update_attribute :sort_order_position, direction
    head :ok
  end

  protected

  def permitted_params
    params.require(:language).permit(:name, :is_rtl)
  end

  def fetch_language
    @language = Language.find params[:id]
  end
end
