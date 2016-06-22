# == Schema Information
#
# Table name: documents
#
#  id                    :integer          not null, primary key
#  title                 :string(255)
#  document_type_id      :integer
#  pdf                   :string(255)
#  processed             :boolean          default(TRUE)
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
#  summary               :text
#  published_at          :datetime
#  citation              :text
#  gregorian_year        :integer
#  gregorian_month       :integer
#  gregorian_day         :integer
#

class Document < ActiveRecord::Base
  include PdfParser
  alias_attribute :name, :title

  # Callbacks
  before_save :set_processed
  before_save :prepend_http_to_source_url
  before_save :set_published_at
  after_commit :generate_images

  # Validations
  validates :title, presence: true
  validates :contributor_id, presence: true
  validates :document_type_id, presence: true
  validates :language_id, presence: true
  validates :popular_count, numericality: true
  validates :gregorian_year, numericality: true, allow_nil: true
  validates :gregorian_month, numericality: true, allow_nil: true
  validates :gregorian_day, numericality: true, allow_nil: true
  validates :featured_position, allow_blank: true, inclusion: {
    in: 1..3,
    message: 'Must be between 1 and 3'
  }
  validates :document_style, inclusion: {
    in: ['scan', 'noscan', 'scannotext'],
    message: 'Must be scan w/ text, scan w/o text, or no-scan'
  }

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

  # Solr Indexing
  searchable auto_index: false do
    text :title, :source_name, :author, :translators, :editors, :publisher,
         :summary

    text :page_texts do
      pages.map {|page| strip_control_characters page.body.text }
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

    string :sort_author do
      if author.present?
        author.split(',').first.split(' ').last
      else
        contributor.last_name
      end
    end

    time :gregorian_date
    time :lunar_hijri_date
    boolean :published
  end

  def self.filter_by_params(collection, params)
    return collection if params.nil?
    docs = collection.search { fulltext params }
    docs.results
  end

  def self.featured
    where.not(featured_position: nil).order(:featured_position).limit(3)
  end

  def self.latest
    order('published_at DESC')
  end

  def self.popular
    order('popular_count DESC')
  end

  def self.published
    where(published: true)
  end

  def self.unpublished
    where(published: false)
  end

  def gregorian_date
    if gregorian_year
      Date.new(gregorian_year, gregorian_month || 1, gregorian_day || 1)
    else
      created_at
    end
  end

  def lunar_hijri_date
    gregorian_date.to_time.to_hijri
  end

  def lunar_hijri_day
    lunar_hijri_date.day
  end

  def lunar_hijri_month
    lunar_hijri_date.month
  end

  def lunar_hijri_year
    lunar_hijri_date.year
  end

  def thumb
    pages[0] && pages[0].image.thumb
  end

  def extract_pages
    pdf = File.open(self.pdf.current_path, 'rb').read
    images = Magick::Image.from_blob(pdf) do
      self.format = 'PDF'
      self.quality = 100
      self.density = 300
    end
    pages = Grim.reap(self.pdf.current_path).to_a
    pages = [images, pages].transpose
    pages.each do |image, page|
      img_path = "#{Rails.root}/tmp/pdf-#{self.id}-#{page.number}.jpg"
      image.alpha = Magick::DeactivateAlphaChannel if image.alpha?
      image.to_blob
      image.write(img_path) do
        self.format = 'JPG'
        self.antialias = true
        self.colorspace = Magick::RGBColorspace
        self.interlace = Magick::NoInterlace
        self.size = 1024
        self.quality = 100
        self.density = 300
      end
      source_page = self.pages.build(image: File.open(img_path),
                                       number: page.number)
      source_page.build_body
      hybrid_text = build_text_by_hybrid(page.text, img_path)
      source_page.body.text = txt_to_html(page.text)          # standard method text
      source_page.body.hybrid_text = txt_to_html(hybrid_text) # hybrid method text
      source_page.save!
      Rails.logger.info "Page #{page.number} of #{images.size} processed"
    end
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
      self.published = false
    end
    return true
  end

  def prepend_http_to_source_url
    return if self.source_url.blank?
    unless self.source_url =~ /^https?:\/\//
      self.source_url = "http://#{self.source_url}"
    end
  end

  def strip_control_characters(value)
    return value unless value.is_a? String
    value.chars.inject("") do |str, char|
      unless char.ascii_only? and (char.ord < 32 or char.ord == 127)
        str << char
      end
      str
    end
  end

  def set_published_at
    if self.published && self.published_changed?
      self.published_at = Time.now
    end
  end

  def txt_to_html text
    krmd = Kramdown::Document.new(text || "").to_html
    processed = Nokogiri::HTML::DocumentFragment.parse(krmd)
    processed.css("p").each do |node|
      # right-to-left if text is Arabic
      node["class"] = "rtl" if !!(node.text =~ /\p{Arabic}/)
    end
    return processed.to_html
  end

end
