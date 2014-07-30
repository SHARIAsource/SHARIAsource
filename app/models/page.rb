class Page < ActiveRecord::Base
  has_many :bodies, dependent: :destroy
  belongs_to :source
  mount_uploader :image, ImageUploader
end
