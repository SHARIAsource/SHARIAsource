$(document).on('page:change', function() {
  var $docType= $('#document_document_type_id')

  function showOrHidePanels() {
    var isCommentary = $docType.find(':selected').text() === 'Commentary'
    $('.js-commentary-only').toggle(isCommentary)
    $('.js-source-only').toggle(!isCommentary)
  }

  showOrHidePanels()
  $docType.on('change.doctypeswitcher', showOrHidePanels)
})
