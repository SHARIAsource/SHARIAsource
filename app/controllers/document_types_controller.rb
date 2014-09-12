class DocumentTypesController < ApplicationController
  def index
    @document_types = DocumentType.hash_tree
  end
end
