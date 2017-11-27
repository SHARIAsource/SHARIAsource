$(document).on('page:change', function() {
  var $docStyle= $('#document_document_style')
  //TODO: bailout if !$docStyle

  function showOrHidePanels() {
    var style = $docStyle.find(':selected').val()
    $('.new_document, .edit_document').attr('data-docstyle', style)
  }

  function tweakSaveAndEditButton() {
    var style = $docStyle.find(':selected').val()
    var button = $('#new_create_and_edit')
      button.prop('title', '');
      button.prop('disabled', false);
  }

  showOrHidePanels()
  tweakSaveAndEditButton()
  $docStyle.on('change.docstyleswitcher', showOrHidePanels)
  $docStyle.on('change.docstyleswitcher', tweakSaveAndEditButton)
})
