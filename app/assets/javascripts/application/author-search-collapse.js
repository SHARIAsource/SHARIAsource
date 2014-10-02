(function() {
  $(document).on('page:change', function() {
    $('.author-search .filter-block')
    .not('.filter-author .filter-block')
    .addClass('is-contracted')
    .find('.filter-content')
    .slideUp(0)
  })
}())
