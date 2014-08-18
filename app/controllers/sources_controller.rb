class SourcesController < ApplicationController
  def show
    @source = Source.find params[:id]
    PopularityWorker.perform_async('Source', @source.id, 'increment!')
    PopularityWorker.perform_in(3.months, 'Source', @source.id, 'decrement!')
  end
end
