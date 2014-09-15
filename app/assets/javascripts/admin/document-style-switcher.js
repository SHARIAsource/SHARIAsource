$(document).on('page:change', function() {
  var $docStyle= $('#document_document_style')

  function showOrHidePanels() {
    var isScan = $docStyle.find(':selected').val() === 'scan'
    $('.js-scan-only').toggle(isScan)
    $('.js-noscan-only').toggle(!isScan)
  }

  showOrHidePanels()
  $docStyle.on('change.docstyleswitcher', showOrHidePanels)
})
