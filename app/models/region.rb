class Region < ActiveRecord::Base
  acts_as_tree order: 'name'
  validates :name, presence: true, uniqueness: true
  has_and_belongs_to_many :documents
end
