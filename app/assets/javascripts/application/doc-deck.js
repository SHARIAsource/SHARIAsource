var $document = $(document)

$document.on('page:change', function() {
  if ($('.deck-container').length) {
    $.deck()
  }
})

$document.on('deck.change', function(event, from, to) {
  var $viewer = $.deck('getSlide', to).find('.image-viewer')
  var dragon = $viewer.data('dragon')
  var width, height

  if (!dragon) {
    width = parseInt($viewer.data('width'), 10)
    height = parseInt($viewer.data('height'), 10)
    url = $viewer.data('src')
    dragon = new OpenSeadragon({
      element: $viewer[0],
      hash: 'viewer' + to,
      tileSources: {
        type: 'legacy-image-pyramid',
        levels: [{
          url: url,
          width: width,
          height: height
        }]
      }
    })
    $viewer.data('dragon', dragon)
  }
})
