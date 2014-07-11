(function() {
  function nestHierarchies() {
    $('.hierarchy').each(function xxx() {
      var $hierarchy = $(this)
      var $items = $hierarchy.find('li')
      $items.each(function yyy() {
        var $this = $(this)
        var parentId = $this.data('parent-id')
        var $parent = $items.filter('[data-id="' + parentId + '"]')
        if (!$parent.children('ul').length) {
          $parent.append('<ul />')
        }
        $parent.children('ul').append($this)
      })
      $hierarchy.addClass('complete')
    })
  }

  $(document).on('page:change', nestHierarchies)
}())
