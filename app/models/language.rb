class Language < ActiveRecord::Base
  include RankedModel
  include Sortable

  default_scope { rank(:sort_order) }

  validates :name, presence: true, uniqueness: true
  has_many :documents
  ranks :sort_order
end
