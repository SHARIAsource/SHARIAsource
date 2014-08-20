class DocumentsController < ApplicationController
  def show
    @document = Document.find params[:id]
    PopularityWorker.perform_async(@document.id, 'increment!')
    PopularityWorker.perform_in(3.months, @document.id, 'decrement!')
  end
end
