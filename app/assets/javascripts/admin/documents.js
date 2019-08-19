var onDocumentFormSubmit = function() {
  var mode = $('.edit_document .tabs li.active a').attr('href');

  if(mode === '#pdf-with-ocr') {
    $('#pdf-only').remove();
  }
  else {
    $('#pdf-with-ocr').remove();
  }
};

var initDocumentTabs = function() {
  $('.edit_document').on('submit', onDocumentFormSubmit);

  if($('.edit_document .tabs').data('action') === "edit") {
    $('.edit_document .tabs').remove();
  }
};

$(document).on('turbolinks:load', initDocumentTabs);
