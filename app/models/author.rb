class Author < ActiveRecord::Base
  include RankedModel
  include Sortable

  default_scope { rank(:sort_order) }

  ranks :sort_order

  has_and_belongs_to_many :document
  belongs_to :user, optional: true

  validates :name, presence: true
end
