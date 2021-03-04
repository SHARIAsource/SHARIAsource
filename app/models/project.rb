class Project < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  mount_uploader :photo, ImageUploader

  has_many :projects_users, dependent: :destroy
  has_many :users, through: :projects_users
  has_many :named_filters

  validates :name, presence: true
  validates :featured_position, allow_blank: true, inclusion: {
    in: 1..3,
    message: 'Must be between 1 and 3'
  }
  accepts_nested_attributes_for :projects_users, :allow_destroy => true

  def self.featured
    where.not(featured_position: nil).order(:featured_position).limit(3)
  end

  def self.published
    where(published: true)
  end

end
