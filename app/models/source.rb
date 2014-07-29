# == Schema Information
#
# Table name: sources
#
#  id               :integer          not null, primary key
#  title            :string(255)
#  region_id        :integer
#  document_type_id :integer
#

class Source < ActiveRecord::Base
  after_commit :generate_images
  alias_attribute :name, :title

  validates :title, presence: true

  has_and_belongs_to_many :themes
  has_and_belongs_to_many :topics
  has_and_belongs_to_many :tags
  has_and_belongs_to_many :eras
  belongs_to :region
  belongs_to :document_type

  mount_uploader :pdf, PdfUploader

  private

  def generate_images
    PdfToImagesWorker.perform_async self.id
  end
end
