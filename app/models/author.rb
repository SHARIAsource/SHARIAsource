class Author < ActiveRecord::Base
  has_and_belongs_to_many :document
  belongs_to :user, optional: true

  validates :name, presence: true
end
