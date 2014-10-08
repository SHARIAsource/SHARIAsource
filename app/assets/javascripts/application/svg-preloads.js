(function() {
  $(window).on('load', function() {
    $('.preloads span').each(function() {
      $('<img>').attr('src', $(this).data('src'))
    })
  })
}())
