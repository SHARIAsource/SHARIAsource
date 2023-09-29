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
//= require dataTables/jquery.dataTables
//= require dataTables/jquery.dataTables.foundation
//= require foundation
//= require turbolinks
//= require openseadragon
//= require ./jquery.ba-throttle-debounce
//= require ./trunk8
//= require ./waypoints/waypoints
//= require d3
//= require leaflet
//= require jquery.calendars.package-2.1.0/js/jquery.plugin.js
//= require jquery.calendars.package-2.1.0/js/jquery.calendars.js
//= require jquery.calendars.package-2.1.0/js/jquery.calendars.plus.js
//= require jquery.calendars.package-2.1.0/js/jquery.calendars.picker.js
//= require jquery.calendars.package-2.1.0/js/jquery.calendars.islamic.js
//= require_tree ./application/


$(document).on('turbolinks:load', function() {
  $(document).foundation()

  // Google Analytics
  gtag('config', 'G-7GTRWL3LSC', {'page_location': event.data.url});

  if(location.href.match('.*/admin/.*')) {
    document.body.innerHTML = "";
    location.reload(true);
  }
})

// $(function(){ $(document).foundation(); });
