(function() {
  var $document = $(document)

  var FilterBlock = function(block) {
    var $block = $(block)
    var $checkboxes = $block.find('li input[type="checkbox"]')
    var $texts = $block.find('input[type="text"]')
    var $all = $block.find('.all input[type="checkbox"]')
    var $multiples = $block.find('select[multiple]')

    function handleAllChanges() {
      $all.on('change.filter', function(event) {
        $checkboxes.prop('checked', false)
        $checkboxes.parent().removeClass('checked soft')
        $all.prop('checked', true)
        $all.parent().addClass('checked')
        $texts.val('')
        $multiples.find('option').prop('selected', false)
        event.preventDefault()
      })
    }

    function handleCheckboxChanges() {
      $checkboxes.on('change.filter', function(event) {
        var $checked = $checkboxes.filter(':checked')
        var $this = $(this)
        if ($checked.length === $checkboxes.length || !$checked.length) {
          $all.prop('checked', true)
          $all.parent().addClass('checked')
          $checkboxes.prop('checked', false)
          $checkboxes.parent().removeClass('checked')
        }
        else {
          $all.prop('checked', false)
          $all.parent().removeClass('checked')
        }
        $this.parent().toggleClass('checked', this.checked).removeClass('soft')
      })
    }

    function handleMultipleSelectChanges() {
      $multiples.on('change.filter', function(event) {
        var allShouldBeChecked = !$multiples.find('option:selected').length
        $all.prop('checked', allShouldBeChecked)
        $all.parent().toggleClass('checked', allShouldBeChecked)
      })
    }

    function handleHierarchyParentChanges() {
      $checkboxes.on('change.filter', function(event) {
        var $children = $(this).closest('label').next().find('input')
        $children.prop('checked', this.checked)
        $children.parent().toggleClass('checked', this.checked)
      })
    }

    function handleSingleHierarchy(element) {
      var $this = $(element)
      var $siblings = $this.closest('li').siblings().andSelf().find('input')
      var $checked = $siblings.filter(':checked')
      var $parent = $this.closest('ul')
      var $parentInputs = $parent.prev().find('input:not(.all input)')
      var shouldBeChecked = $checked.length === $siblings.length
      var parentSoft = !shouldBeChecked && $checked.length
      if ($parentInputs.length) {
        $parentInputs.prop('checked', shouldBeChecked)
        $parentInputs.parent().toggleClass('checked', shouldBeChecked)
        $parentInputs.parent().toggleClass('soft', !!parentSoft)
        if (!$parent.hasClass('filter-hierarchy')) {
          handleSingleHierarchy($parentInputs[0])
        }
      }
    }

    function handleHierarchyChildrenChanges() {
      $checkboxes.on('change.filter', function(event) {
        handleSingleHierarchy(this)
      })
    }

    function handleDateChanges() {
      $texts.on('keyup.filter', function(event) {
        var val = ''
        $texts.each(function() {
          val += $(this).val()
        })
        $all.prop('checked', !val)
        $all.parent().toggleClass('checked', !val)
      })
    }

    function checkInitialStates() {
      var $checked = $checkboxes.filter(':checked')
      var $children = $checked.closest('label').next().find('input')
      var $opts = $multiples.find('option')
      var $selOpts = $opts.filter(':selected')
      var hasChecked = $checked.length && $checked.length !== $checkboxes.length
      var hasSelected = $selOpts.length && $selOpts.length != $opts.length

      $checked.closest('.check-label').addClass('checked')
      $children.parent().addClass('checked')

      if (hasChecked || hasSelected) {
        $all.prop('checked', false)
        $all.closest('label').removeClass('checked')
      }
      $texts.trigger('keyup')
      $checked.trigger('change')
    }

    handleMultipleSelectChanges()
    handleHierarchyParentChanges()
    handleHierarchyChildrenChanges()
    handleDateChanges()
    handleCheckboxChanges()
    handleAllChanges()
    checkInitialStates()
  }

  $document.on('turbolinks:load', function() {
    $('.filter-block').each(function() {
      var $block = $(this)
      if (!$block.data('blockPlugin')) {
        $block.data('blockPlugin', new FilterBlock(this))
      }
    })
  })

  $document.on('click.filter', '.clear-all', function(event) {
    var scroll = $(window).scrollTop()
    $('.filter-block .all').trigger('click')
    $(window).scrollTop(scroll)
    event.preventDefault()
  })
}())
