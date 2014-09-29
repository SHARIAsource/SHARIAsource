(function() {
  var $document = $(document)
  var autosubmit = $.debounce(100, function() {
    $(this).closest('form').trigger('submit')
  })

  $document.on('ajax:send', '#new_search_filters', function(event) {
    $('.search-results').addClass('loading')
  })

  $document.on('ajax:success', '#new_search_filters', function(event, data) {
    var $results = $(data).find('.search-results').children()
    $('.search-results').empty().append($results)
  })

  $document.on('ajax:complete', '#new_search_filters', function(event, data) {
    $('.search-results').removeClass('loading')
  })

  $document.on('change', '.search-sidebar input[type=checkbox]', autosubmit)
  $document.on('change', '.search-sidebar input[type=radio]', autosubmit)
  $document.on('change', '#search_filters_sort', autosubmit)
}())
