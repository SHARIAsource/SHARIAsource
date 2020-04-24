class DocumentType < ActiveRecord::Base
  include RankedModel
  include Sortable
  extend HashUtils

  has_closure_tree order: 'sort_order'

  validates :name, presence: true, uniqueness: true
  validates :sort_order, numericality: true

  has_many :documents, dependent: :restrict_with_error

  ranks :sort_order, with_same: :parent_id

  def self_and_descendants_document_count
    self.self_and_descendants.joins(:documents)
      .where(documents: { published: true}).count
  end

  def self.topic_counts
    Rails.cache.fetch 'document_type_topic_counts', expires_in: ENV.fetch('SS_DEFAULT_CACHE_PART_EXPIRE', 15).to_i.minutes do
      DocumentTypeCounter.topic_counts
    end
  end

  def self.theme_counts
    Rails.cache.fetch 'document_type_theme_counts', expires_in: ENV.fetch('SS_DEFAULT_CACHE_PART_EXPIRE', 15).to_i.minutes do
      DocumentTypeCounter.theme_counts
    end
  end

  def self.region_counts
    Rails.cache.fetch 'document_type_region_counts', expires_in: ENV.fetch('SS_DEFAULT_CACHE_PART_EXPIRE', 15).to_i.minutes do
      DocumentTypeCounter.region_counts
    end
  end

  def self.era_counts
    Rails.cache.fetch 'document_type_era_counts', expires_in: ENV.fetch('SS_DEFAULT_CACHE_PART_EXPIRE', 15).to_i.minutes do
      DocumentTypeCounter.era_counts
    end
  end

  def self.contributor_counts
    Rails.cache.fetch 'document_type_contributor_counts', expires_in: ENV.fetch('SS_DEFAULT_CACHE_PART_EXPIRE', 15).to_i.minutes do
      DocumentTypeCounter.contributor_counts
    end
  end

  def self.commentary_id
    @commentary_id ||= self.find_by_name('Commentary').id
  end
end
