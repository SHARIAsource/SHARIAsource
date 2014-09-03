class DocumentsController < ApplicationController
  def show
    document = Document.find params[:id]
    unless document.published?
      raise ActiveRecord::RecordNotFound
    end
    PopularityWorker.perform_async(document.id, 'increment!')
    PopularityWorker.perform_in(3.months, document.id, 'decrement!')
    @document = DocumentPresenter.new document
  end
end
