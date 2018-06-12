class Page < ActiveRecord::Base
  validates :number, numericality: { greater_than: 0 }
  validates :width, numericality: true, if: :image?
  validates :height, numericality: true, if: :image?

  has_one :body, dependent: :destroy
  belongs_to :document
  mount_uploader :image, PageImageUploader
  accepts_nested_attributes_for :body
  default_scope { order('number') }
end
