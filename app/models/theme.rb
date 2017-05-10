class Theme < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  has_and_belongs_to_many :documents
  default_scope { order(:name) }
end
