class SourcesController < ApplicationController
  def show
    @source = Source.find params[:id]
    PopularityWorker.perform_async('Source', @source.id, 'increment!')
    PopularityWorker.perform_in(30.seconds, 'Source', @source.id, 'decrement!')
  end
end
