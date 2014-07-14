class Era < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  belongs_to :parent, class_name: 'Era'
  has_many :children, class_name: 'Era', foreign_key: 'parent_id'
end
