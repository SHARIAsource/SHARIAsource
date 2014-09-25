(function() {
  var $document = $(document)

  $document.on('click', '.filter-extend-toggle', function(event) {
    var $this = $(this)
    var $block = $this.closest('.filter-block').toggleClass('is-expanded')
    var text = $this.data('expandtext')
    if ($block.hasClass('is-expanded')) {
      text = $this.data('contracttext')
    }
    $this.text(text)
    $document.trigger('sameheight:refresh')
    event.preventDefault()
  })
}())
