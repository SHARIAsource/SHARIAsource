class Project < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  mount_uploader :photo, ImageUploader

  has_many :projects_users, dependent: :destroy
  has_many :users, through: :projects_users
  has_many :named_filters

  validates :name, presence: true
  validates :slug, uniqueness: true
  accepts_nested_attributes_for :projects_users, :allow_destroy => true
end
