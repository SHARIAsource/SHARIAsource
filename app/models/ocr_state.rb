class OcrState < ActiveRecord::Base
  include Workflow
  belongs_to :document

  workflow state: [ :sending_images, :sending_document, :polling_document_status, :complete]
  workflow status: [ :processing, :error, :ready ]

  def set_error_message(error_message)
    self.update_attributes(status: :error, error_message: error_message)
  end

  def set_document_id(cb_document_id)
    self.update_attributes(cb_document_id: cb_document_id)
  end

  class Error < StandardError
  end
end
