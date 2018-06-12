$(document).on('turbolinks:load', function() {
  var $docStyle= $('#document_document_style')
  //TODO: bailout if !$docStyle

  function showOrHidePanels() {
    var style = $docStyle.find(':selected').val()
    $('.new_document, .edit_document').attr('data-docstyle', style)
  }

  function tweakSaveAndEditButton() {
  }

  showOrHidePanels()
  tweakSaveAndEditButton()
  $docStyle.on('change.docstyleswitcher', showOrHidePanels)
  $docStyle.on('change.docstyleswitcher', tweakSaveAndEditButton)
})
