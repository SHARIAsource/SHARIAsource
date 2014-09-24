# == Schema Information
#
# Table name: documents
#
#  id                    :integer          not null, primary key
#  title                 :string(255)
#  document_type_id      :integer
#  pdf                   :string(255)
#  processed             :boolean          default(TRUE)
#  gregorian_date        :date
#  lunar_hijri_date      :date
#  source_name           :string(255)
#  source_url            :string(255)
#  author                :string(255)
#  translators           :string(255)
#  editors               :string(255)
#  publisher             :string(255)
#  publisher_location    :string(255)
#  volume_count          :integer
#  alternate_titles      :string(255)
#  alternate_authors     :string(255)
#  language_id           :integer
#  contributor_id        :integer
#  popular_count         :integer          default(0)
#  created_at            :datetime
#  updated_at            :datetime
#  featured_position     :integer
#  reference_type_id     :integer
#  permission_giver      :string(255)
#  published             :boolean          default(FALSE)
#  document_style        :string(255)      default("scan")
#  alternate_editors     :string(255)
#  alternate_translators :string(255)
#  alternate_years       :string(255)
#

class Document < ActiveRecord::Base
  attr_accessor :gregorian_date_string, :lunar_hijri_date_string
  alias_attribute :name, :title

  # Callbacks
  before_save :set_processed
  before_save :prepend_http_to_source_url
  after_commit :generate_images

  # Validations
  validates :title, presence: true
  validates :contributor_id, presence: true
  validates :document_type_id, presence: true
  validates :language_id, presence: true
  validates :popular_count, numericality: true
  validates :featured_position, allow_blank: true, inclusion: {
    in: 1..3,
    message: 'Must be between 1 and 3'
  }
  validates :document_style, inclusion: {
    in: ['scan', 'noscan'],
    message: 'Must be scan or no-scan'
  }
  validate :validate_dates

  # Associations
  has_and_belongs_to_many :themes
  has_and_belongs_to_many :topics
  has_and_belongs_to_many :tags
  has_and_belongs_to_many :eras
  has_and_belongs_to_many :regions
  has_and_belongs_to_many :referenced_documents, class_name: 'Document',
    join_table: :document_documents, foreign_key: :document_id,
    association_foreign_key: :referenced_id
  has_and_belongs_to_many :referencing_documents, class_name: 'Document',
    join_table: :document_documents, foreign_key: :referenced_id,
    association_foreign_key: :document_id
  has_many :pages, dependent: :destroy
  has_one :body
  belongs_to :document_type
  belongs_to :reference_type
  belongs_to :language
  belongs_to :contributor, class_name: 'User'

  # Misc
  mount_uploader :pdf, PdfUploader
  accepts_nested_attributes_for :pages, :body
  default_scope { order('created_at DESC') }

  # Solr Indexing
  searchable ignore_attribute_changes_of: [:popular_count] do
    text :title, :source_name, :author, :translators, :editors, :publisher

    text :page_texts do
      pages.map {|page| page.body.text }
    end

    text :body_text do
      body.text if body
    end

    integer :theme_ids, multiple: true
    text :themes do
      themes.pluck :name
    end

    integer :topic_ids, multiple: true
    text :topics do
      topics.pluck :name
    end

    text :tags do
      tags.pluck :name
    end

    integer :era_ids, multiple: true
    text :eras do
      eras.pluck :name
    end

    integer :region_ids, multiple: true
    text :regions do
      regions.pluck :name
    end

    integer :language_id
    text :language do
      language.name
    end

    integer :contributor_id
    text :contributor_name do
      contributor.name
    end

    integer :document_type_id
    text :document_type do
      document_type.name
    end
  end

  def self.published
    where(published: true)
  end

  def self.featured
    where.not(featured_position: nil).order(:featured_position)
  end

  def thumb
    pages[0] && pages[0].image.thumb
  end

  private

  def generate_images
    changes = self.previous_changes
    if changes.include?(:pdf) && changes[:pdf].first != changes[:pdf].last
      PdfToImagesWorker.perform_async self.id
    end
  end

  def set_processed
    pdf_updated = self.pdf_changed? && !self.new_record?
    new_with_pdf = self.new_record? && self.pdf.present?
    if pdf_updated || new_with_pdf
      self.processed = false
    end
    return true
  end

  def prepend_http_to_source_url
    return if self.source_url.blank?
    unless self.source_url =~ /^https?:\/\//
      self.source_url = "http://#{self.source_url}"
    end
  end

  def validate_dates
    ['gregorian_date', 'lunar_hijri_date'].each do |attr|
      attr_string = attr + '_string'
      if self.public_send(attr_string).present?
        begin
          date = self.public_send(attr_string).split('-')[0..2].map(&:to_i)
          self.public_send(attr + '=', Date.new(*date).to_s)
        rescue ArgumentError
          self.errors[attr_string] << 'Invalid Date'
        end
      else
        self.public_send(attr + '=', nil)
      end
    end
  end
end
