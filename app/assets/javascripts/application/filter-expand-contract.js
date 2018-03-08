(function() {
  var $document = $(document)
  var $filterHeader

  function checkExpandContractAll() {
    $filterHeader.removeClass('all-expanded all-contracted')
    if ($('.filter-block').length === $('.is-contracted').length) {
      $filterHeader.addClass('all-contracted')
    }
    if (!$('.filter-block.is-contracted').length) {
      $filterHeader.addClass('all-expanded')
    }
  }
  $document.on('click', '.summary-expand-contract', function(event) {
    var $block = $(this).closest('.summary-block')
    $block.toggleClass('is-contracted')
    $block.find('.summary-content').slideToggle(300)
    var new_text = $block.hasClass('is-contracted') ? 'Show Summary' : 'Hide Summary'
    $(this).find('a.summary-link').text(new_text)

    event.preventDefault()
  })

  $document.on('click', '.filter-block .expand-contract', function(event) {
    var $block = $(this).closest('.filter-block')

    if ($('.search-full-width').length) {
      return false;
    }

    $block.toggleClass('is-contracted')
    $block.find('.filter-content').slideToggle(300)
    checkExpandContractAll()
    event.preventDefault()
  }).on('click', '.filter-header .expand-all a', function(event) {
    var $this = $(this)

    $filterHeader.addClass('all-expanded')
    $('.filter-block.is-contracted .expand-contract').trigger('click')
    event.preventDefault()
  }).on('click', '.filter-header .contract-all a', function(event) {
    var $this = $(this)

    $filterHeader.addClass('all-contracted')
    $('.filter-block:not(.is-contracted) .expand-contract').trigger('click')
    event.preventDefault()
  }).on('turbolinks:load', function() {
    var checkedSelector = 'input[type="checkbox"]:checked:not(.all input)'
    var $blocks = $('.filter-block')
    var $checked = $blocks.find(checkedSelector)
    var $selected = $blocks.find('option:selected')
    var $filled = $blocks.find('input[type="text"]').filter(function() {
      return !!$(this).val()
    })
    var $expand = $checked.add($selected).add($filled).closest('.filter-block')

    $filterHeader = $('.filter-header')
    $expand.removeClass('is-contracted')
    $expand.find('.filter-content').slideToggle(300)
    checkExpandContractAll()
    $document.trigger('filtersummary:refresh')
  })
}())
