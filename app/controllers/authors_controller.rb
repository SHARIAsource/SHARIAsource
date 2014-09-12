class AuthorsController < ApplicationController
  def index
    @author_table = DocumentType.author_counts
  end

  def show
  end
end
