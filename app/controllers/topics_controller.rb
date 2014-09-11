class TopicsController < ApplicationController
  def index
    @topic_table = DocumentType.topic_counts
    @theme_table = DocumentType.theme_counts
  end
end
