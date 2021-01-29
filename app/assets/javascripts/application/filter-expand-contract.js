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

    $('.filter-block:not(.is-contracted) .filter-content').slideToggle(300)
  }

  // Result summary
  $document.on('click', '.summary-expand-contract', function(event) {
    var $block = $(this).closest('.summary-block')
    $block.toggleClass('is-contracted')
    $block.find('.summary-content').slideToggle(300)
    var new_text = $block.hasClass('is-contracted') ? 'Show Summary' : 'Hide Summary'
    $(this).find('a.summary-link').text(new_text)

    event.preventDefault()
  })

  // Geographic areas side arrow
  $document.on('click', '.toggle-collapse', function(event) {
    var $el = $(event.currentTarget)

    var $ul = $($el.parent().find('ul'))

    if($ul.hasClass('collapsed')) {
      $ul.removeClass('collapsed')
      $el.text($el.data('alt-title'))
    }
    else {
      $ul.addClass('collapsed')
      $el.text($el.data('title'))

      $el.parent().find('input[type=checkbox]:checked').parent().click()
    }
  });

  // Filter block titles
  $document.on('click', '.filter-block .expand-contract', function(event) {
    var $block = $(this).closest('.filter-block')
    console.log($block);

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
    var $filled = $blocks.find('input[type="text"], input[type=date]').filter(function() {
      return !!$(this).val()
    })
    var $expand = $checked.add($selected).add($filled).closest('.filter-block')

    $filterHeader = $('.filter-header')
    $expand.removeClass('is-contracted')
    checkExpandContractAll()
    $document.trigger('filtersummary:refresh')
  })
}())
