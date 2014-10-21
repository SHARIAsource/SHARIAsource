# == Schema Information
#
# Table name: document_types
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  parent_id  :integer
#  sort_order :integer
#

class DocumentType < ActiveRecord::Base
  extend HashUtils

  acts_as_tree order: 'sort_order ASC'
  validates :name, presence: true, uniqueness: true
  validates :sort_order, numericality: true
  has_many :documents

  def self_and_descendants_document_count
    self.self_and_descendants.joins(:documents).count
  end

  def self.topic_counts
    Rails.cache.fetch 'document_type_topic_counts' do
      DocumentTypeCounter.topic_counts
    end
  end

  def self.theme_counts
    Rails.cache.fetch 'document_type_theme_counts' do
      DocumentTypeCounter.theme_counts
    end
  end

  def self.region_counts
    Rails.cache.fetch 'document_type_region_counts' do
      DocumentTypeCounter.region_counts
    end
  end

  def self.era_counts
    Rails.cache.fetch 'document_type_era_counts' do
      DocumentTypeCounter.era_counts
    end
  end

  def self.contributor_counts
    Rails.cache.fetch 'document_type_contributor_counts' do
      DocumentTypeCounter.contributor_counts
    end
  end

  def self.commentary_id
    @commentary_id ||= self.find_by_name('Commentary').id
  end
end
