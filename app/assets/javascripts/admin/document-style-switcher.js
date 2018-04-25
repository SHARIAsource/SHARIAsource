$(document).on('turbolinks:load', function() {
  var $docStyle= $('#document_document_style')
  //TODO: bailout if !$docStyle

  function showOrHidePanels() {
    var style = $docStyle.find(':selected').val()
    $('.new_document, .edit_document').attr('data-docstyle', style)
  }

  function tweakSaveAndEditButton() {
    var style = $docStyle.find(':selected').val()
    var button = $('#new_create_and_edit')
      if (style == 'scan' || style == 'scannotext') {
          button.prop('title', 'This action is only available when Document Style is "No Scan"');
          button.prop('disabled', true);
      }
      else {
          button.prop('title', '');
          button.prop('disabled', false);
      }
  }

  showOrHidePanels()
  tweakSaveAndEditButton()
  $docStyle.on('change.docstyleswitcher', showOrHidePanels)
  $docStyle.on('change.docstyleswitcher', tweakSaveAndEditButton)
})
