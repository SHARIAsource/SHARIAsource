xml.instruct! :xml, version: '1.0'
xml.rss version: '2.0' do
  xml.channel do
    xml.title 'NewAppName'
    xml.description 'The online portal for academic content and context on Islamic law'
    xml.link root_url

    for document in @documents
      xml.item do
        xml.title document.title
        if document.document_style == 'scan' && document.pages.present?
          images = []
          document.pages.each do |page|
            url = URI(root_url)
            url.path = page.image.thumb.url
            images.push image_tag(url.to_s)
          end
          xml.description images.join('')
        elsif document.body && document.body.text.present?
          xml.description document.body.text
        else
          xml.description 'No content provided.'
        end
        xml.pubDate document.created_at.to_s(:rfc822)
        xml.link document_url(document)
        xml.guid document_url(document)
      end
    end
  end
end
