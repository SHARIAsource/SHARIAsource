$(document).on('page:change', function() {
  $('.js-same-height-container').each(function() {
    var $items = $(this).find('.js-same-height')
    var heights = $.map($items.get(), function(item) {
      return $(item).height()
    })
    var maxHeight = Math.max.apply(null, heights)
    $items.height(maxHeight)
  })
})
