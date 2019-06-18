class Project < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  mount_uploader :photo, ImageUploader

  scope :published, -> { where(published: true) }

  has_many :projects_users, dependent: :destroy
  has_many :users, through: :projects_users
  has_many :named_filters

  validates :name, presence: true
  accepts_nested_attributes_for :projects_users, :allow_destroy => true
end
