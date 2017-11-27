var ready;
ready = function() {
  var is_editing = $('#document_content').length > 0 &&  $('#document_content')[0].getAttribute("data-document") === "edit_document";

  if (is_editing) {
    reset_form = setInterval(function(){
      console.log("Reseting form");
      //$('.scan-only').load(window.location.href + " scan-only")
      $.ajax({
        url: window.location.href,
        cache: false,
        success: function(edit_form){
          var scan_only_div = edit_form.search('<div class="scan-only panel">');
          var next_div = edit_form.search('<div class="noscan-only panel">') - 1;
          var scan_only_html = edit_form.substr(scan_only_div, next_div - scan_only_div );
          $(".scan-only").replaceWith(scan_only_html);
          clearInterval(reset_form);
        }
      });
  }, 2000);}

  if (is_editing) {
    check_status = setInterval(function(){
      if ($('.ready_status').length === 1 || $('.error_status').length === 1) {
        clearInterval(check_status);
      }
      $.ajax({
        url: "cb_status",
        cache: false,
        success: function(status_partial){
          $(".cb_status").html(status_partial);
        }
      });
  }, 4000)};
};
$(document).ready(ready);
$(document).on('page:load', ready);
