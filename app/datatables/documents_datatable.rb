class DocumentsDatatable
  include ActionView::Helpers::FormHelper 
  delegate :params, :h, :link_to, :form_for, :t,
  :document_path, :edit_admin_document_path, :admin_document_path, to: :@view

  def initialize(view, status)
    @view = view
    @status = status
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Document.where(published:@status).count,
      iTotalDisplayRecords: documents.count,
      aaData: data
    }
  end

private

  def data
    documents.map do |document|
      row = [
        document.title,
        document.publisher,
        document.tags.pluck(:name).join(', '),
        document.topics.pluck(:name).join(', '),
        document.contributor.name,
        document.language.name,
        document.regions.pluck(:name).join(', '),
        document.updated_at.strftime("%b %e, %l:%M %p"),
        actions_for_user(document).html_safe
      ]
      row
    end
  end

  def actions_for_user(document)
    content = ["<ul class='inline-list'>"]
    content << "<li>" + link_to('View', document_path(document), class: 'tiny radius pill button') + "</li>"
    content << "<li>" + link_to( I18n.translate('edit'), edit_admin_document_path(document), class: 'tiny radius pill button') + "</li>"
    unless document.published
      content << "<li>" + form_for(document, as: :document, url: admin_document_path(document)) do |f|
        f.hidden_field :published, value: true
        f.submit 'Publish', class: 'tiny radius warning pill button'
      end + "</li>"
    else
      content << "<li>" + form_for(document, as: :document, url: admin_document_path(document)) do |f|
        f.hidden_field :published, value: false
        f.submit 'Unpublish', class: 'tiny radius warning pill button'
      end + "</li>"
    end
    content << "<li>" + link_to(t('delete'), admin_document_path(document), class: 'tiny radius alert pill button',
                method: :delete, data: { confirm: t('helpers.delete_confirm', model: Document.model_name.human)}) + "</li>"
    return content.join("")
  end

  def documents
    @documents = fetch_documents
  end

  def fetch_documents
    documents = ordered_docs
    documents = documents.page(page).per_page(per_page)
    if params[:sSearch].present?
        documents = Document.where(published:@status).search do
          fulltext params[:sSearch]
        end.results
    end
    documents
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def ordered_docs
    columns = %w[title publisher tags topics contributor language regions updated_at]
    col = columns[params[:iSortCol_0].to_i]
    docs = Document.where(published:@status)
    case col
    when "title","publisher", "updated_at" then docs.order("#{col} #{sort_direction}")
    when "topics" then docs.joins(:topics).order("topics.name #{sort_direction}")
    when "tags" then docs.includes(:tags).order("tags.name #{sort_direction}")
    when "contributor" then docs.joins(:contributor).order("users.last_name #{sort_direction}")
    when "language" then docs.joins(:language).order("languages.name #{sort_direction}")
    when "regions" then docs.joins(:regions).order("regions.name #{sort_direction}")
    end
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end

end
