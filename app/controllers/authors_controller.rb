class AuthorsController < ApplicationController
  def index
    @author_table = DocumentType.author_counts
  end

  def show
    @author = User.find params[:id]
  end
end
