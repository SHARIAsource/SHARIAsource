(function() {
  var $document = $(document)

  var FilterBlock = function(block) {
    var $block = $(block)
    var $checkboxes = $block.find('li input[type="checkbox"]')
    var $texts = $block.find('input[type="text"]')
    var $all = $block.find('.all input[type="checkbox"]')

    function handleAllChanges() {
      $all.on('change.filter', function(event) {
        $checkboxes.prop('checked', false)
        $all.prop('checked', true)
      })
    }

    function handleCheckboxChanges() {
      $checkboxes.on('change.filter', function(event) {
        var $checked = $checkboxes.filter(':checked')
        if ($checked.length === $checkboxes.length || !$checked.length) {
          $all.prop('checked', true)
          $checkboxes.prop('checked', false)
        }
        else {
          $all.prop('checked', false)
        }
      })
    }

    function handleHierarchyParentChanges() {
      $checkboxes.on('change.filter', function(event) {
        var $children = $(this).closest('label').next().find('input')
        $children.prop('checked', this.checked)
      })
    }

    function handleHierarchyChildrenChanges() {
      $checkboxes.on('change.filter', function(event) {
        var $this = $(this)
        var $siblings = $this.closest('li').siblings().andSelf().find('input')
        var $checked = $siblings.filter(':checked')
        var $parents = $this.parentsUntil('.filter-hierarchy', 'ul')
        var $parentInputs = $parents.prev().find('input:not(.all input)')
        $parentInputs.prop('checked', $checked.length === $siblings.length)
      })
    }

    handleAllChanges()
    handleCheckboxChanges()
    handleHierarchyParentChanges()
    handleHierarchyChildrenChanges()
  }

  $document.on('page:change', function() {
    $('.filter-block').each(function() {
      var $block = $(this)
      if (!$block.data('blockPlugin')) {
        $block.data('blockPlugin', new FilterBlock(this))
      }
    })
  })
}())
