(function() {
  var $document = $(document)
  var viewerCount = 0;

  function extractPageImages($viewer) {
    return $.map($viewer.find('.image').get(), function(img) {
      var $img = $(img)
      return {
        type: 'legacy-image-pyramid',
        levels: [{
          url: $img.data('src'),
          width: parseInt($img.data('width'), 10),
          height: parseInt($img.data('height'), 10)
        }]
      }
    })
  }

  function createDragon($viewer, pages) {
    return new OpenSeadragon({
      element: $viewer[0],
      hash: 'viewer' + viewerCount++,
      tileSources: pages,
      showHomeControl: false,
      prefixUrl: '/assets/',
      zoomInButton: 'js-zoomin-link',
      zoomOutButton: 'js-zoomout-link',
      fullPageButton: 'js-fullscreen-link',
      previousButton: 'js-prev-link',
      nextButton: 'js-next-link',
      navigationControlAnchor: OpenSeadragon.ControlAnchor.TOP_RIGHT,
      sequenceControlAnchor: OpenSeadragon.ControlAnchor.BOTTOM_LEFT,
      navigatorSizeRatio: 0.1
    })
  }

  $document.on('page:change', function() {
    var $viewer = $('.image-viewer')
    var dragon = $viewer.data('dragon')
    var pages, width, height, $texts

    if (!dragon && $viewer.length) {
      pages = extractPageImages($viewer)
      dragon = createDragon($viewer, pages)
      $viewer.data('dragon', dragon)
      dragon.innerTracker.scrollHandler = false
      $('.controls .total').text(pages.length)
      $texts = $viewer.closest('.image-viewer-container').find('.page-text')
      $texts.eq(0).addClass('active')
      dragon.addHandler('page', function(info) {
        var length = info.eventSource.tileSources.length
        $('.status .current').text(info.page + 1)
        $texts.filter('.active').removeClass('active')
        $texts.eq(info.page).addClass('active')
        $('#js-first-link').toggleClass('disabled', !info.page)
        $('#js-last-link').toggleClass('disabled', info.page === length - 1)
      })
      dragon.addHandler('pre-full-screen', function(info) {
        if (info.fullScreen) {
          $('.image-viewer-container .controls').appendTo('.image-viewer')
        }
      })
      dragon.addHandler('full-screen', function(info) {
        $('.image-viewer .controls').appendTo('.image-viewer-container')
      })
    }
  })


  $document.on('click', '#js-first-link:not(.disabled)', function(event) {
    $('.image-viewer').data('dragon').goToPage(0)
    event.preventDefault()
  })


  $document.on('click', '#js-last-link:not(.disabled)', function(event) {
    var dragon = $('.image-viewer').data('dragon')
    dragon.goToPage(dragon.tileSources.length - 1)
    event.preventDefault()
  })
}())
