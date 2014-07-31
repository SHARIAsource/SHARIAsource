class Page < ActiveRecord::Base
  has_one :body, dependent: :destroy
  belongs_to :source
  mount_uploader :image, ImageUploader
  accepts_nested_attributes_for :body
end
