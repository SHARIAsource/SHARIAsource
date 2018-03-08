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

    if (!$summary.length) {
      return
    }

    $first.trunk8(documentOptions);
    var dat = $first.data('trunk8');
    wasTruncated = dat !== undefined && dat !== null && dat.original_text !== $first.html()

    if ($paragraphs.length > 2 || wasTruncated) {
      $summary.addClass('truncated')
    }
    else {
      $summary.addClass('no-truncation')
    }
  }

  $(document).on('turbolinks:load', function() {
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
