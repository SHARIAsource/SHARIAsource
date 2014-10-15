module DocumentHelper
  def document_email_share(document)
    [
      'mailto:?subject=SHARIAsource.com: ',
      CGI.escape("#{document.title} by #{document.author_or_contributor}"),
      '&body=',
      CGI.escape("#{document.title} by #{document.author_or_contributor}"),
      CGI.escape("\n\n"),
      CGI.escape(document_url(document.object))
    ].join('')
  end

  def document_twitter_share(document)
    author = document.author_or_contributor
    url = CGI.escape(document_url(document.object))
    title_length_max = 120 - author.length - url.length
    shortened_title = document.title
    if document.title.length > title_length_max
      shortened_title = document.title.slice(0, title_length_max)
      if shortened_title.slice(-1) == " "
        shortened_title = shortened_title.trim
      else
        shortened_title = shortened_title.split(' ')
        shortened_title.pop
        shortened_title = shortened_title.join(' ')
      end
      shortened_title += '…'
    end
    [
      "https://twitter.com/share?url=#{url}",
      '&via=SHARIAsource&text=',
      CGI.escape("#{shortened_title} by #{author}")
    ].join('')
  end
end
