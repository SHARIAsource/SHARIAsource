class CommentariesController < ApplicationController
  def show
    @commentary = Commentary.find params[:id]
    PopularityWorker.perform_async('Commentary', @commentary.id, 'increment!')
    PopularityWorker.perform_in(3.months, 'Commentary', @commentary.id,
                                'decrement!')
  end
end
