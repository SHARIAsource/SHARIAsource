module DocumentHelper
  def document_email_share(document)
    [
      'mailto:?subject=SHARIAsource.com: ',
      CGI.escape("#{document.title} by #{document.author_or_contributor}"),
      '&body=',
      CGI.escape("#{document.title} by #{document.author_or_contributor}"),
      CGI.escape("\n\n"),
      CGI.escape("#{document_url(document.object)}")
    ].join('')
  end
end
