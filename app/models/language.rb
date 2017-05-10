class Language < ActiveRecord::Base
  include RankedModel

  validates :name, presence: true, uniqueness: true
  has_many :documents
  ranks :sort_order
end
