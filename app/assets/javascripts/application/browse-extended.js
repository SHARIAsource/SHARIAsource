(function() {
  var $document = $(document)

  function updateAllState() {
    var $expands = $('.js-expand')
    var $expandeds = $expands.filter('.is-expanded')
    var allExpanded = $expands.length === $expandeds.length
    var $all = $('.expand-all')

    $all.text($all.data(allExpanded ? 'contract-text' : 'expand-text'))
    $all.toggleClass('js-contract-all', allExpanded)
    $all.toggleClass('js-expand-all', !allExpanded)
  }

  $document.on('turbolinks:load', function() {
    function arrowHtml(depth) {
      var $el = $('<tr data-depth="' + depth + '"></tr>')
      var $th = $('<th scope="row"></th>')
      var i = 0, len = $('.browse-table th[scope=col]').length - 1
      $el.append($th.append('<a href="#" class="expand js-expand">Expand</a>'))
      for (; i < len; i++) {
        $el.append('<td></td>')
      }
      return $el
    }

    function createArrowIfExtended(element, depth) {
      var $children = $(element).nextUntil('[data-depth=' + depth + ']')
      $children = $children.filter('[data-depth=' + (depth + 1) + ']')

      if ($children.is('[data-extended]')) {
        $children.last().after(arrowHtml(depth + 1))
      }

      $children.each(function() {
        createArrowIfExtended(this, depth + 1)
      })
    }

    $('.browse-table [data-depth=0]').each(function() {
      createArrowIfExtended(this, 0)
    })
  })

  $document.on('click', '.js-expand', function(event) {
    var $this = $(this)
    var $tr = $this.closest('tr')
    var depth = parseInt($tr.data('depth'), 10)
    var $targets = $tr.prevUntil('[data-depth=' + (depth - 1) + ']')

    $targets = $targets.filter('[data-depth=' + depth + '][data-extended]')
    $targets[$this.hasClass('is-expanded') ? 'hide' : 'show']()
    $this.toggleClass('is-expanded')
    event.preventDefault()
    updateAllState()
    $.waypoints('refresh')
  })

  $document.on('click', '.js-expand-all', function(event) {
    $('.js-expand').not('.is-expanded').trigger('click')
  })

  $document.on('click', '.js-contract-all', function(event) {
    $('.js-expand.is-expanded').trigger('click')
  })
}())
