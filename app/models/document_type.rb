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
    roots = DocumentType.roots.select(:id, :name)
    topics = Topic.select(:id, :name)
    {
      topics: topics,
      document_types: roots,
      counts: topics.map do |t|
        roots.map do |d|
          t.documents.published
            .where(document_type: d.self_and_descendant_ids).count
        end
      end
    }
  end

  def self.theme_counts
    roots = DocumentType.roots.select(:id, :name)
    themes = Theme.select(:id, :name, :archived)
    {
      themes: themes,
      document_types: roots,
      counts: themes.map do |t|
        roots.map do |d|
          t.documents.published
            .where(document_type: d.self_and_descendant_ids).count
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
          region.documents.published
            .where(document_type: d.self_and_descendant_ids).count
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
          era.documents.published
            .where(document_type: d.self_and_descendant_ids).count
        end
      end
    }
  end

  def self.contributor_counts
    roots = DocumentType.roots.select(:id, :name)
    contributors = User.joins(:documents).distinct
    {
      contributors: contributors,
      document_types: roots,
      counts: contributors.map do |a|
        roots.map do |d|
          a.documents.where(document_type: d.self_and_descendant_ids).count
        end
      end
    }
  end

  def self.commentary_id
    @commentary_id ||= self.find_by_name('Commentary').id
  end
end
