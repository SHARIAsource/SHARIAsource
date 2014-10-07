(function() {
  $(document).on('click', '.filter-block .expand-contract', function(event) {
    var $block = $(this).closest('.filter-block')
    $block.toggleClass('is-contracted')
    $block.find('.filter-content').slideToggle(300, function() {
      $(document).trigger('sameheight:refresh')
    })
    event.preventDefault()
  })
}())
