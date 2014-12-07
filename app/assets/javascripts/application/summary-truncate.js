(function() {
  var documentOptions = {
    lines: 3,
    fill: '&nbsp;&hellip;',
    tooltip: false
  }

  function truncateHomepage() {
    $('.home-block .summary').each(function() {
      $(this).find('p').first().trunk8({
        lines: 3,
        fill: '&nbsp;&hellip;'
      })
    })
  }

  function truncateDocument() {
    var $summary = $('.document .summary')
    var $paragraphs = $summary.find('p')
    var $first = $paragraphs.first()
    var wasTruncated

    $first.trunk8(documentOptions)
    wasTruncated = $first.data('trunk8').original_text !== $first.html()

    if ($paragraphs.length > 2 || wasTruncated) {
      $summary.addClass('truncated')
    }
    else {
      $summary.addClass('no-truncation')
    }
  }

  $(document).on('page:change', function() {
    truncateHomepage()
    truncateDocument()

  }).on('click', '.document .summary .expand a', function(event) {
    $('.document .summary p').first().trunk8('revert')
    $('.document .summary').removeClass('truncated')
    event.preventDefault()

  }).on('click', '.document .summary .collapse a', function(event) {
    truncateDocument()
    event.preventDefault()
  })
}())
