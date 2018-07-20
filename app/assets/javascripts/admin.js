// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require dataTables/jquery.dataTables
//= require dataTables/jquery.dataTables.foundation
//= require foundation
//= require select2-full
//= require turbolinks
//= require admin-inits
//= require tinymce
//= require smart_listing
//= require_tree ./admin
//= require plupload-2.3.1/js/plupload.full.min
// xrequire plupload-2.3.1/js/moxie
// xrequire plupload-2.3.1/js/plupload.dev
//= require plupload-2.3.1/js/jquery.ui.plupload/jquery.ui.plupload

$(document).on('turbolinks:load', function() {
  $(document).foundation()

  if(!location.href.match('.*/admin/.*') && !location.href.match('.*/users/.*')) {
    document.body.innerHTML = "";
    location.reload(true);
  }
})
