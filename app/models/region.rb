class Region < ActiveRecord::Base
  include RankedModel
  include Sortable

  has_closure_tree order: 'sort_order'

  validates :name, presence: true, uniqueness: true
  has_and_belongs_to_many :documents

  ranks :sort_order, with_same: :parent_id
end
