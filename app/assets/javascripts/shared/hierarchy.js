(function() {
  function nestHierarchies() {
    $('.hierarchy').each(function xxx() {
      var $items = $(this).find('li')
      $items.each(function yyy() {
        var $this = $(this)
        var parentId = $this.data('parent-id')
        var $parent = $items.filter('[data-id="' + parentId + '"]')
        if (!$parent.children('ul').length) {
          $parent.append('<ul />')
        }
        $parent.children('ul').append($this)
      })
    })
  }

  $(document).on('page:change', nestHierarchies)
}())
