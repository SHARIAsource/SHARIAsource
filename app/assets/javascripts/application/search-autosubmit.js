(function() {
  var $document = $(document)
  var autosubmit = $.debounce(100, function() {
    $(this).closest('form').trigger('submit')
  })

  $document.on('ajax:send', function(event) {
    if (event.target.id === 'new_search_filters') {
      $('.search-results').addClass('loading')
    }
    else if ($(event.target).is('.more-results a')) {
      var $loading = $('<span class="ss-button">Loading</span>')
      $loading.css('opacity', 0)
      $('.more-results a').fadeOut(150, function() {
        $(this).after($loading)
        $loading.animate({ opacity: 0.5 }, 150)
      })
    }
  })

  $document.on('ajax:success', function(event, data) {
    var $results

    if (event.target.id === 'new_search_filters') {
      $results = $(data).find('.search-results').children()
      $('.search-results').empty().append($results)
    }
    else if ($(event.target).is('.more-results a')) {
      $results = $(data).find('.result')
      $('.more-results').remove()
      $('.search-results .result-list').append($results)
      $('.search-results').append($(data).find('.more-results'))
    }
    $document.trigger('sameheight:refresh')
  })

  $document.on('ajax:complete', '#new_search_filters', function(event, data) {
    $('.search-results').removeClass('loading')
  })

  $document.on('change', '.search-sidebar input[type=checkbox]', autosubmit)
  $document.on('change', '.search-sidebar input[type=radio]', autosubmit)
  $document.on('change', '#search_filters_sort', autosubmit)
}())
