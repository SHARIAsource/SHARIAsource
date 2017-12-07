require 'securerandom'

class Document < ActiveRecord::Base
  include HasManyAttachedFiles
  include PdfParser
  alias_attribute :name, :title

  attr_accessor :new_content_password, :reviewing_user

  BASE_PAGE_DIRECTORY = Rails.root.join('tmp', 'pdf-pages').to_s.freeze
  NO_TEXT_MESSAGE = "No text to show"

  before_save :set_processed
  before_save :prepend_http_to_source_url
  before_save :set_published_at
  after_save :log_review
  after_commit :generate_images

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
  has_many :document_reviews, -> { order(:created_at) }, dependent: :destroy

  def current_review  #TODO: private
    document_reviews.last if reviewed?
  end

  def reviewed_by_name
    return nil unless reviewed?

    reviewer = current_review.try(:user)
    reviewer.try(:name)
  end

  def reviewed_at
    current_review.try(:created_at)
  end

  has_one :body
  belongs_to :document_type
  belongs_to :reference_type
  belongs_to :language
  belongs_to :contributor, class_name: 'User'
  belongs_to :user

  scope :published, -> { where(published: true) }

  mount_uploader :pdf, PdfUploader
  accepts_nested_attributes_for :pages, :body

  searchable auto_index: false do
    # TODO: I think we need to strip summary too
    text :title, :source_name, :author, :translators, :editors, :publisher

    text :summary do
      strip_control_characters summary
    end

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
      language.try(:name)
    end

    integer :id, multiple: true

    integer :user_id

    integer :contributor_id
    text :contributor_name do
      contributor.try(:name)
    end

    integer :document_type_id
    text :document_type do
      document_type.try(:name)
    end

    string :sort_author do
      if author.present?
        author.split(',').first.split(' ').last
      else
        contributor.try(:last_name)
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

  def log_review
    if changes['reviewed'] == [false, true]
      raise 'Cannot mark document as reviewed without a reviewing_user' unless reviewing_user
      self.document_reviews << DocumentReview.new(user: reviewing_user)
    end
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

  def boop(x)
    # puts "boop #{x}: #{Time.now.to_i}"
  end

  def set_new_content_password
    # NOTE: This lets us lazily just set content_password = new_content_password
    # (in the view) as a no-op when the pre-existing content_password isn't changing
    self.new_content_password = self.content_password.presence || SecureRandom.hex.first(8)
  end

  def authenticate_content_password(password)
    password == content_password
  end

  def pdf_pages
    begin
      PDF::Reader.new(pdf.current_path).pages
    rescue PDF::Reader::MalformedPDFError => e
      # TODO: save this error in self.processing_error
      Rails.logger.warn e.to_s
      puts e.to_s
      return []
    end
  end

  def self.repair_pages_days_older_than(days)
    # TODO: do this in batches with: Document.in_batches(50).each_record ...
    # if this has old pages on disk, repair_pdf(...)
    Document.all.map { |doc| doc.repair_pdf days }
  end

  def repair_pdf(days)
    return unless pdf?

    unless pdf.file.try(:exists?)
      puts "WARNING: #{self.class.name} id #{id} missing expected PDF on disk: #{pdf.file.path}"
      return
    end

    has_old_pages = pages.any? do |page|
      # puts (Time.now - File.stat(page.image.file.path).mtime) / 1.hour / 24
      page.image? && ((Time.now - File.stat(page.image.file.path).mtime) / 1.hour / 24) > days
    end

    regenerate_pdf(false) if has_old_pages
  end

  def extract_pages(with_text=false)
    # NOTE: for doc 1121, this block takes 80 seconds with default qual or density info
    # other note: with qual and dens, it definitely uses 30+GB of memory inside that loop
    # with qual:90 and density:300, it takes 450 seconds, so 5 times longer with with no qual or dens attrs.
    return unless pdf.file.try(:exists?)

    pages = pdf_pages
    page_count = pages.count

    if page_count == 0
      msg = "Fatal: Failed to parse pages from document id #{id}"
      puts msg
      Rails.logger.info msg
      return
    end

    # TODO: handle failures in extract_pdf_images_to_disk by adding a nil image and detecting it here
    #   Ideally, we would use a stock "this page is unavailable" image instead
    images = extract_pdf_images_to_disk(page_count: page_count)

    message = "Images successfully generated for document #{id}."
    message += " Now parsing all #{page_count} pages of text." if with_text
    puts message
    Rails.logger.info message

    self.processed = false
    self.pages.destroy_all

    images.each_with_index do |image, idx|
      puts "Analyzing image: #{image}"
      source_page = Page.new(image: File.open(image), number: idx + 1)
      source_page.build_body

      if with_text
        # There was a problem with PDF::Reader back in the day, so don't use it here.
        begin
          page = pages[idx]
          puts "Firing build_text_by_hybrid for page #{idx}..."
          source_page.body.text = txt_to_html(page.text)

          hybrid_text = build_text_by_hybrid(page.text, image)
          source_page.body.hybrid_text = txt_to_html(hybrid_text)
        rescue ArgumentError => _
          source_page.body.text = ""
          source_page.body.hybrid_text = ""
        end
      else
        source_page.body.text = NO_TEXT_MESSAGE
        source_page.body.hybrid_text = NO_TEXT_MESSAGE
      end

      puts "Saving page #{source_page.number} of #{page_count}" 
      self.pages << source_page  #This saves the source_page
      source_page = nil

      # NOTE: Force garbage collection to try and prevent unreasonably heavy memory use
      GC.start
    end

    self.processed = true
    self.save!

    GC.start
    clean_up_temp_images(images)

    log_message = "Image generation #{'and text parsing ' if with_text}complete for document #{self.id}"
    puts log_message
    Rails.logger.info log_message
  end

  def clean_up_temp_images(images)
    return if images.empty?

    image = images.first
    image_dir = File.dirname(image)
    msg = "Cleaning up temp images in #{image_dir}"
    puts msg
    logger.info msg

    images.each {|filename| File.delete(filename) if File.exists?(filename)}

    # Only try to delete the temp directory for *this* doc, if it's empty
    if id.to_s == File.basename(image_dir) && (Dir.entries(image_dir) - %w{ . .. }).empty?
      FileUtils.remove_dir(image_dir)
    end
  end

  def extract_pdf_images_to_disk(options)
    page_count = options[:page_count]
    base_dir = BASE_PAGE_DIRECTORY + "/#{id}"
    puts "Extracting to #{base_dir} (#{page_count} pages)"
    FileUtils.mkdir_p(base_dir) unless Dir.exists?(base_dir)

    # NOTE: A larger batch size will use more memory inside the each_slice loop and
    #   they don't reduce total processing time like you'd think. Keep it small.
    page_batch_size = 5

    images = []
    (0..page_count-1).each_slice(page_batch_size) do |endpoints|
      start_index = endpoints.first
      end_index = endpoints.last
      new_images = extract_page_range(start_index: start_index, end_index: end_index)
      
      new_images.each_with_index do |image, idx|
        global_page_number = start_index + idx
        img_path = BASE_PAGE_DIRECTORY + "/#{id}/pdf-#{id}-#{global_page_number}.jpg"
        images << img_path
        # puts "Creating image: #{img_path}"

        image.alpha = Magick::DeactivateAlphaChannel if image.alpha?
        image.to_blob
        image.write(img_path) do
          self.format = 'JPG'
          self.antialias = true
          self.colorspace = Magick::RGBColorspace
          self.interlace = Magick::NoInterlace
          self.size = 1024
          self.quality = 85
          self.density = 300
        end
        image = nil
      end
      new_images = nil

      # NOTE: Ruby garbage collection doesn't keep up and memory use can hit 60MB per page easily
      GC.start
    end

    images
  end

  def extract_page_range(options)
    # Extracts a range of pages from a PDF. ImageMagick's `convert` lets you specify
    #   page ranges. We use that here to minimize our memory footprint.
    start_index = options[:start_index]
    end_index = options[:end_index]

    convert_string = "#{pdf.current_path}[#{start_index}-#{end_index}]"
    puts "Extracting: #{convert_string}"

    Magick::Image.read(convert_string) do
      self.format = 'PDF'
      self.quality = 100  # has no significant effect on memory usage
      # NOTE: Using '300' here makes it use 300x more memory than the default (72)
      #   which we handle by explicitly calling Ruby garbage collection in extract_pages()
      self.density = 300
    end
  end

  def regenerate_pdf(with_text)
    extract_pages(with_text)
  end

  def self.regenerate_all(options={})
    with_text = options[:with_text]
    single_id = options[:id]
    query = {document_style: ['scan', 'scannotext']}  #460 page pdf is id: 1121, 4-pager is 1119
    query.merge!(id: single_id) if single_id

    doc_ids = Document.where(query).order("random()").select(:id, :pdf) do |doc|
      !!doc.pdf.current_path
    end.map(&:id)

    if doc_ids.empty?
      puts "Notice: Did not find any documents for the following query params:"
      ap query
      return
    end

    doc_ids.each do |doc_id|
      puts "#{Time.now} - Firing id: #{doc_id}"
      PdfToImagesWorker.new.perform(doc_id, with_text)
    end
  end

  def viewable_by?(user)
    return published? if user.nil?

    user.is_superuser? || user.is_editor? || self.user == user || contributor.self_and_ancestors.include?(user)
  end

  private

  def generate_images
    changes = self.previous_changes
    if changes.include?(:pdf) && changes[:pdf].first != changes[:pdf].last
      PdfToImagesWorker.perform_async(id)
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
