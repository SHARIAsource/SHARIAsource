class DocumentType < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  belongs_to :parent, class_name: 'DocumentType'
  has_many :children, class_name: 'DocumentType', foreign_key: 'parent_id'
end
