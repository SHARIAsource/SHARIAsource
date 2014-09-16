class DocumentsController < ApplicationController
  def show
    document = Document.published.find params[:id]
    PopularityWorker.perform_async(document.id, 'increment!')
    PopularityWorker.perform_in(3.months, document.id, 'decrement!')
    @document = DocumentPresenter.new document
  end
end
