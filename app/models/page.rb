class Page < ActiveRecord::Base
  validates :number, numericality: { greater_than: 0 }
  validates :width, numericality: true
  validates :height, numericality: true

  has_one :body, dependent: :destroy
  belongs_to :document
  mount_uploader :image, PageImageUploader
  accepts_nested_attributes_for :body
  default_scope { order('number') }
end
