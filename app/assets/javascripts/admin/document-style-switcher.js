$(document).on('page:change', function() {
  var $docStyle= $('#document_document_style')

  function showOrHidePanels() {
    var style = $docStyle.find(':selected').val()
    $('.new_document, .edit_document').attr('data-docstyle', style)
  }

  showOrHidePanels()
  $docStyle.on('change.docstyleswitcher', showOrHidePanels)
})
