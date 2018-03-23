class Project < ActiveRecord::Base
  mount_uploader :photo, ImageUploader

  has_many :projects_users, dependent: :destroy
  has_many :users, through: :projects_users
  has_many :named_filters

  validates :name, presence: true
  accepts_nested_attributes_for :projects_users, :allow_destroy => true
end
