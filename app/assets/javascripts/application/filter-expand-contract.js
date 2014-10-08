(function() {
  $(document).on('click', '.filter-block .expand-contract', function(event) {
    var $block = $(this).closest('.filter-block')
    var $filterHeader = $('.filter-header')

    if ($('.search-full-width').length) {
      return false;
    }

    $block.toggleClass('is-contracted')

    $block.find('.filter-content').slideToggle(300)

    $filterHeader.removeClass('all-expanded all-contracted')
    if ($('.filter-block').length === $('.is-contracted').length) {
      $filterHeader.addClass('all-contracted')
    }
    if (!$('.filter-block.is-contracted').length) {
      $filterHeader.addClass('all-expanded')
    }
    event.preventDefault()
  }).on('click', '.filter-header .expand-all a', function(event) {
    var $this = $(this)

    $('.filter-header').addClass('all-expanded')
    $('.filter-block.is-contracted .expand-contract').trigger('click')
    event.preventDefault()
  }).on('click', '.filter-header .contract-all a', function(event) {
    var $this = $(this)

    $('.filter-header').addClass('all-contracted')
    $('.filter-block:not(.is-contracted) .expand-contract').trigger('click')
    event.preventDefault()
  })
}())
