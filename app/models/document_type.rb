# == Schema Information
#
# Table name: document_types
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  parent_id  :integer
#

class DocumentType < ActiveRecord::Base
  extend HashUtils

  acts_as_tree order: 'sort_order ASC'
  validates :name, presence: true, uniqueness: true
  validates :sort_order, numericality: true
  has_many :documents

  def self.topic_counts
    roots = DocumentType.roots.select(:id, :name)
    topics = Topic.select(:id, :name)
    {
      topics: topics,
      document_types: roots,
      counts: topics.map do |t|
        roots.map do |d|
          t.documents.where(document_type: d.self_and_descendant_ids).count
        end
      end
    }
  end

  def self.theme_counts
    roots = DocumentType.roots.select(:id, :name)
    themes = Theme.select(:id, :name)
    {
      themes: themes,
      document_types: roots,
      counts: themes.map do |t|
        roots.map do |d|
          t.documents.where(document_type: d.self_and_descendant_ids).count
        end
      end
    }
  end

  def self.region_counts
    roots = DocumentType.roots.select(:id, :name)
    regions = hash_flatten(Region.hash_tree)
    {
      regions: regions,
      document_types: roots,
      counts: regions.map do |region|
        roots.map do |d|
          region.documents.where(document_type: d.self_and_descendant_ids).count
        end
      end
    }
  end

  def self.era_counts
    roots = DocumentType.roots.select(:id, :name)
    eras = hash_flatten(Era.hash_tree)
    {
      eras: eras,
      document_types: roots,
      counts: eras.map do |era|
        roots.map do |d|
          era.documents.where(document_type: d.self_and_descendant_ids).count
        end
      end
    }
  end
end
