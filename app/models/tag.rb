class Tag < ActiveRecord::Base
  include RankedModel
  include Sortable

  default_scope { rank(:sort_order) }

  validates :name, presence: true, uniqueness: true
  has_and_belongs_to_many :documents

  ranks :sort_order
end
