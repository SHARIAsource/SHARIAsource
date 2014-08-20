# == Schema Information
#
# Table name: documents
#
#  id                 :integer          not null, primary key
#  title              :string(255)
#  document_type_id   :integer
#  pdf                :string(255)
#  processed          :boolean          default(TRUE)
#  gregorian_date     :date
#  lunar_hijri_date   :date
#  source_name        :string(255)
#  source_url         :string(255)
#  author             :string(255)
#  translators        :string(255)
#  editors            :string(255)
#  publisher          :string(255)
#  publisher_location :string(255)
#  volume_count       :integer
#  alternate_titles   :string(255)
#  alternate_authors  :string(255)
#  language_id        :integer
#  contributor_id     :integer
#  popular_count      :integer          default(0)
#  created_at         :datetime
#  updated_at         :datetime
#  featured_position  :integer
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
  validates :popular_count, numericality: true
  validates :featured_position, allow_blank: true, inclusion: {
    in: 1..3,
    message: 'Must be between 1 and 3'
  }
  validate :validate_dates

  # Associations
  has_and_belongs_to_many :themes
  has_and_belongs_to_many :topics
  has_and_belongs_to_many :tags
  has_and_belongs_to_many :eras
  has_and_belongs_to_many :reference_types
  has_and_belongs_to_many :regions
  has_and_belongs_to_many :referenced_documents, class_name: 'Document',
    join_table: :document_documents, foreign_key: :document_id,
    association_foreign_key: :referenced_id
  has_many :pages, dependent: :destroy
  has_one :body
  belongs_to :document_type
  belongs_to :language
  belongs_to :contributor, class_name: 'User'

  mount_uploader :pdf, PdfUploader
  accepts_nested_attributes_for :pages, :body
  default_scope { order('created_At DESC') }

  def self.featured
    self.where.not(featured_position: nil).order(:featured_position)
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
