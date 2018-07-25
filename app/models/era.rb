class Era < ActiveRecord::Base
  include RankedModel
  include Sortable

  has_closure_tree order: 'sort_order'

  after_commit :clear_cache

  validates :name, presence: true, uniqueness: true
  validates :start_year_gregorian, numericality: true, allow_blank: true
  validates :end_year_gregorian, numericality: true, allow_blank: true
  validates :start_year_hijri, numericality: true, allow_blank: true
  validates :end_year_hijri, numericality: true, allow_blank: true

  has_and_belongs_to_many :documents

  ranks :sort_order, with_same: :parent_id

  def clear_cache
    Rails.cache.delete 'document_type_era_counts'
  end
end
