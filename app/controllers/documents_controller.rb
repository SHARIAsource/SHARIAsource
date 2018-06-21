class DocumentsController < ApplicationController
  def show
    document = Document.find params[:id]
    if document.viewable_by?(current_user)
      PopularityWorker.perform_async(document.id, 'increment!')
      PopularityWorker.perform_in(3.months, document.id, 'decrement!')
    else
      # TODO: Display a less hostile warning message
      flash[:notice] = "You must be signed in and authorized to see this document"
      redirect_to '/users/login'
    end
    @document = DocumentPresenter.new document
  end

  def index
    @documents = Document.published.limit(20)
    respond_to do |format|
      format.rss { render layout: false }
    end
  end

  def download
    document = Document.find params[:document_id]
    send_file document.pdf.file.path
  end

  def secure_content
    @document = Document.find params[:document_id]

    password = params[:password][:content_password]
    correct_password = @document.authenticate_content_password(password)

    respond_to do |format|
      if correct_password
        @show_secure_content = true
        if @document.pages.present?
          partial = 'scan_viewer'
        else
          partial = 'body_text'
        end
        format.html { render partial: partial, layout: false }
      else
        format.html { render html: '', layout: false, status: :error }
      end
    end
  end

end
