class DocumentType < ActiveRecord::Base
  acts_as_tree
  validates :name, presence: true, uniqueness: true
end
