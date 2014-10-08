(function() {
  var preloads = [
    'browse-contract-hover.svg',
    'browse-expand-hover.svg',
    'docs-email-hover.svg',
    'docs-facebook-hover.svg',
    'docs-first-hover.svg',
    'docs-last-hover.svg',
    'docs-next-hover.svg',
    'docs-prev-hover.svg',
    'docs-print-hover.svg',
    'docs-twitter-hover.svg',
    'facebook-hover.svg',
    'linkedin-hover.svg',
    'rss-hover.svg',
    'search-magglass-hover.svg',
    'twitter-hover.svg'
  ]

  $(window).on('load', function() {
    $.each(preloads, function(i, src) {
      $('<img>').attr('src', '/assets/' + src)
    })
  })
}())
