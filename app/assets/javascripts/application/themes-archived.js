(function() {
  var $document = $(document)

  $document.on('click', '.js-expand-themes', function(event) {
    var $this = $(this)
    var expanded = $this.hasClass('is-expanded')

    $this.text($this.data(expanded ? 'expandtext' : 'contracttext'))
    $this.add('[data-archived]').toggleClass('is-expanded', !expanded)
    $document.trigger('sameheight:refresh')
    event.preventDefault()
  })
}())
