(function() {
  var $document = $(document)

  $document.on('click.tagsuggestion', '.js-suggest-tags', function(event) {
    $('.tag-suggestion-form').show()
    $(this).css('visibility', 'hidden')
    $document.trigger('sameheight:refresh')
    event.preventDefault()
  })

  $document.on('click.tagsuggestion', '.js-tag-cancel', function(event) {
    $('.js-suggest-tags').css('visibility', 'visible')
    $('.tag-suggestion-form').hide()
    $document.trigger('sameheight:refresh')
    event.preventDefault()
  })
}())
