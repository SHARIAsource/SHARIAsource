class RegionsController < ApplicationController
  def index
    @region_table = DocumentType.region_counts
  end
end
