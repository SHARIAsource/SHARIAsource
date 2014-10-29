(function() {
  $(document).on('filtersummary:refresh', function() {
    var $blocks = $('.filter-block')
    var $checked = $('.check-label.checked')
    var $selected = $blocks.find('option:selected')
    var $filled = $blocks.find('input[type="text"]').filter(function() {
      return !!$(this).val()
    })
    var $resultSummary = $('.result-count')

    function appendSummaryFilter(name, val) {
      var $summaryFilter = $('<span class="result-summary-filter"></span>')
      var fixedName = name.replace('[]', '').replace('_', ' ')
      $summaryFilter.append('<span class="name">' + fixedName + ': </span>')
      $summaryFilter.append('<span class="val">' + val + '</span>')
      $resultSummary.append($summaryFilter)
    }

    $checked = $checked.not('.soft, .all, .checked + ul .checked')
    $checked.each(function() {
      var $this = $(this)
      var name = $this.find('input[type="checkbox"]').attr('name')
      var val = $this.text()
      appendSummaryFilter(name, val)
    })

    $selected.each(function() {
      var $this = $(this)
      appendSummaryFilter($this.closest('select').attr('name'), $this.text())
    })

    $filled.each(function() {
      var $this = $(this)
      appendSummaryFilter($this.attr('name'), $this.val())
    })
  })
}())
