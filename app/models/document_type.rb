class DocumentType < ActiveRecord::Base
  acts_as_tree order: 'name'
  validates :name, presence: true, uniqueness: true
end
