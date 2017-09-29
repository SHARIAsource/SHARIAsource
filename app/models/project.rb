class Project < ActiveRecord::Base
  mount_uploader :photo, ImageUploader

  has_and_belongs_to_many :users

  validates :name, presence: true
end
