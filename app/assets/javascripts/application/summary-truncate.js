(function() {
  $(document).on('page:change', function() {
    $('.home-block .summary p').first().trunk8({
      lines: 3,
      fill: '&nbsp;&hellip;'
    })

    $('.document .summary').trunk8({
      lines: 2,
      fill: '&nbsp;&hellip; <a href="#" class="expand">Expand Summary</a>'
    })
  }).on('click', '.document .summary .expand', function(event) {
    var collapse = '<p class="collapse"><a href="#">Collapse Summary</a></p>'
    $(this).closest('.summary').trunk8('revert').append(collapse)
    event.preventDefault()
  }).on('click', '.document .summary .collapse a', function(event) {
    var $this = $(this)
    var $summary = $this.closest('.summary')
    $this.closest('p').remove()
    $summary.removeAttr('title').trunk8()
    event.preventDefault()
  })
}())
