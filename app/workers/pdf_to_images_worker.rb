class PdfToImagesWorker
  include Sidekiq::Worker

  def perform(source_id)
    source = Document.find source_id
    source.pages.destroy_all
    extract_pages source
    source.update! processed: true
  end

  private

  def extract_pages(source)
    images = Magick::ImageList.new(source.pdf.current_path).to_a
    reader = PDF::Reader.new(source.pdf.current_path)
    pages = [images, reader.pages].transpose
    pages.each do |image, page|
      path = "#{Rails.root}/tmp/pdf-#{source.id}-#{page.number}.jpg"
      image.alpha = Magick::DeactivateAlphaChannel if image.alpha?
      image.write(path) do
        self.antialias = true
        self.colorspace = Magick::RGBColorspace
        self.interlace = Magick::NoInterlace
        self.size = 1024
        self.quality = 70
        self.density = 150
      end
      source_page = source.pages.build(image: File.open(path),
                                       number: page.number)
      source_page.build_body
      text = Kramdown::Document.new(page.text || '').to_html
      processed = Nokogiri::HTML::DocumentFragment.parse(text)
      (processed.css("code") + processed.css("pre")).each { |node| node.name = "p" }
      source_page.body.text = processed.to_html
      source_page.save!
      File.delete path
    end
  end
end
