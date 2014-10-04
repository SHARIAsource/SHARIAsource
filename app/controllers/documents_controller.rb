class DocumentsController < ApplicationController
  def show
    document = Document.find params[:id]
    if document.published
      PopularityWorker.perform_async(document.id, 'increment!')
      PopularityWorker.perform_in(3.months, document.id, 'decrement!')
    elsif !document.contributor.self_and_ancestors.include?(current_user)
      raise ActiveRecord::RecordNotFound
    end
    @document = DocumentPresenter.new document
  end
end
