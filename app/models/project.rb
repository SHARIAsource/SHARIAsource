class Project < ActiveRecord::Base
  mount_uploader :photo, ImageUploader

  has_and_belongs_to_many :users
  has_many :named_filters

  validates :name, presence: true
end
