(function() {
  $(document).on('ajax:send', function(event) {
    var $target = $(event.target)
    var $tr = $target.closest('tr')

    if ($target.is('table .sort-up')) {
      $tr.prev().before($tr)
    }
    else if ($target.is('table .sort-down')) {
      $tr.next().after($tr)
    }
  })
}())
