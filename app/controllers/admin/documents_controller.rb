class Admin::DocumentsController < AdminController
  before_action :fetch_document, only: [:edit, :update, :destroy]
  before_action :ensure_editor!, only: [:destroy]
  before_action :fetch_collection, only: [ :index ]

  def index
  end

  def new
    @document = current_user.documents.build
    # TODO: These should probably be done in after_initialize (if: :new_record?) callbacks
    @document.build_body
    @document.set_new_content_password
  end

  def edit
    @document.set_new_content_password
  end

  def create
    # If current_user is allowed to set contributor, use value from them.
    #   Otherwise, set the contributor to the current_user
    document_params = permitted_params
    document_params[:contributors] ||= [current_user]

    # create new authors
    document_params[:author_ids] = create_new_attributes document_params[:author_ids], Author if document_params[:author_ids].present?
    # create new editors
    document_params[:editor_ids] = create_new_attributes document_params[:editor_ids], Editor if document_params[:editor_ids].present?
    # create new translators
    document_params[:translator_ids] = create_new_attributes document_params[:translator_ids], Translator if document_params[:translator_ids].present?

    @document = current_user.uploaded_documents.build document_params

    if @document.save
      @document.index!
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
    update_params = permitted_params

    # create new authors
    update_params[:author_ids] = create_new_attributes update_params[:author_ids], Author if update_params[:author_ids].present?
    # create new editors
    update_params[:editor_ids] = create_new_attributes update_params[:editor_ids], Editor if update_params[:editor_ids].present?
    # create new translators
    update_params[:translator_ids] = create_new_attributes update_params[:translator_ids], Translator if update_params[:translator_ids].present?

    # This forces any edit by a non-reviewer to set reviewed to false
    update_params[:reviewed] ||= '0'

    @document.reviewing_user = current_user if update_params[:reviewed] == '1'

    prev_state = @document.published
    if @document.update update_params
      flash[:notice] = 'Document updated successfully'

      @document.index!
      DocumentTypeCountWorker.perform_async

      if params[:create_and_continue]
        path = edit_admin_document_path @document
      elsif params[:create_and_edit]
        path = edit_admin_document_path @document
      else
        # if we unpublish a document, we want to stay on the
        # unpublished view so that we can unpublish another if needed
        if @document.published != prev_state
          if @document.published
            path = unpublished_admin_documents_path
          else
            path = published_admin_documents_path
          end
        else
          path = published_admin_documents_path
        end
      end
      if permitted_params[:document_show_page]
        redirect_back(fallback_location: root_path)
      else
        redirect_to path
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
    # TODO: only include :featured_position if the current_user is allowed to manage it
    whitelist = [
                 :title, :volume_count, :document_type_id, :pdf, :language_id,
                 :gregorian_year, :gregorian_month, :gregorian_day,
                 :source_name, :source_url, :authors, :translators, :editors,
                 :publisher, :publisher_location, :alternate_titles,
                 :alternate_authors, :featured_position, :reference_type_id,
                 :permission_giver, :document_style, :summary, :citation,
                 :alternate_editors, :alternate_translators, :alternate_years,
                 :reviewed,
                 :use_content_password,
                 :content_password,
                 :document_show_page,
                 region_ids: [], theme_ids: [], topic_ids: [], tag_ids: [],
                 referenced_document_ids: [], era_ids: [], author_ids: [],
                 editor_ids: [], translator_ids: [], contributor_ids: [],
                 body_attributes: [:id, :text], pages_attributes: [
                   :id, body_attributes: [:id, :text, :hybrid_text]
                 ]
                ]
    if current_user.is_editor
      whitelist << :contributors
    end
    unless current_user.requires_approval?
      whitelist << :published
    end
    if current_user.is_password_protector?
      whitelist += [:use_content_password, :content_password]
    end

    # This overcomes the duplicated :use_content_password checkbox data caused by
    # the funky partials and show()|hide() trickery used in the UI
    params[:document][:use_content_password] = params[:document][:content_password].present?

    params.require(:document).permit(*whitelist)
  end

  def fetch_document
    @document = Document.find params[:id]
    if !current_user.can_edit?(@document)
      flash[:alert] = "Sorry, but you must be an editor or the owner of that document to do this"
      redirect_back(fallback_location: root_path)
    end
  end

  def render_index(published)
    respond_to do |format|
      format.html
      format.json { render json: response_as_json(published) }
    end
  end

  def response_as_json(pstatus)
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Document.where(published: pstatus).count,
      iTotalDisplayRecords: fetch_documents(pstatus).count,
      aaData: data(pstatus)
    }
  end

  def data(pstatus)
    fetch_documents(pstatus).map do |document|
      [
        document.title,
        document.publisher,
        document.tags.pluck(:name).join(', '),
        document.topics.pluck(:name).join(', '),
        document.contributors.map { |contributor| contributor.first_name + ' ' + contributor.last_name }.join(', '),
        document.language.name,
        document.regions.pluck(:name).join(', '),
       "<i class='fa fa-#{document.reviewed? ? 'check' : 'close'}' aria-hidden='true'></i>",
        document.updated_at.strftime("%b %e, %Y"),
        document.created_at.strftime("%b %e, %Y"),
        render_to_string(
          partial: "/admin/documents/datatable_controls.html.slim",
          locals: {document: document},
          layout: false
        )
      ]
    end
  end

  def fetch_documents(pstatus)
    # Memoize search results because this gets called twice in response_as_json and
    #   produces incorrect "of $x entries" values if we capture its output there.
    return @fetched_documents if defined?(@fetched_documents)

    attrs = {published: pstatus}
    if !current_user.is_superuser?
      # If they are normal user, restrict search to their uploaded docs and their contributor docs
      # Otherwise they are a superuser, so we won't restrict by user or contributor ids
      attrs[:contributor_ids] = current_user.self_and_descendant_ids
      attrs[:user_id] = current_user.id
    end

    search = Sunspot.search(Document) do
      with(:published, attrs[:published])
      fulltext(params[:sSearch]) if params[:sSearch].present?

      any_of do
        [:user_id, :contributor_ids].each do |field_name|
          with(field_name, attrs[field_name]) if attrs[field_name]
        end
      end
    end

    documents = Document
      .where(id: search.results.map(&:id))
      .page(page)
      .per_page(per_page)

    @fetched_documents = order_documents(documents)
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def order_documents(docs)
    columns = %w[title publisher tags topics contributor language regions updated_at]
    col = columns[params[:iSortCol_0].to_i]
    case col
    when "title","publisher", "updated_at" then docs.order("#{col} #{sort_direction}")
    when "topics" then docs.joins(:topics).order("topics.name #{sort_direction}")
    when "tags" then docs.includes(:tags).order("tags.name #{sort_direction}")
    when "contributor" then docs.joins(:contributors).order("users.last_name #{sort_direction}")
    when "language" then docs.joins(:language).order("languages.name #{sort_direction}")
    when "regions" then docs.joins(:regions).order("regions.name #{sort_direction}")
    else docs.order("updated_at #{sort_direction}")
    end
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end

  def create_new_attributes(names, model)
    new_ids = []
    existing = names.select do |single|
      single =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/
    end

    new_attributes = names.reject do |single|
      single =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/
    end

    new_attributes.each do |attr_name|
      next if attr_name.empty?

      new_attr = model.new
      new_attr.name = attr_name
      new_attr.save!

      new_ids << new_attr[:id]
    end

    existing + new_ids
  end

  def fetch_collection
    params[:q] ||= {}
    params[:q][:published_eq] ||= true
    params[:q][:s] ||= {}
    params[:q][:s] ||= "created_at desc"
    @q = Document.ransack(params[:q])
    @all_documents = @q.result
    @documents = @all_documents.page(params[:page])
  end
end
