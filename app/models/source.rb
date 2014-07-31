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
  before_save :set_processed
  after_commit :generate_images
  alias_attribute :name, :title

  validates :title, presence: true

  has_and_belongs_to_many :themes
  has_and_belongs_to_many :topics
  has_and_belongs_to_many :tags
  has_and_belongs_to_many :eras
  has_many :pages, dependent: :destroy
  belongs_to :region
  belongs_to :document_type

  mount_uploader :pdf, PdfUploader
  accepts_nested_attributes_for :pages

  private

  def generate_images
    changes = self.previous_changes
    if changes.include?(:pdf) && changes[:pdf].first != changes[:pdf].last
      PdfToImagesWorker.perform_async self.id
    end
  end

  def set_processed
    if self.pdf_changed? && !self.new_record? || self.new_record? && self.pdf
      self.processed = false
    end
    return true
  end
end
