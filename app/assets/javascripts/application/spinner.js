$( document ).ready(function() {

  // hide sk-circle
  $(".sk-circle").hide();


  // show sk-circle on AJAX start
  $(document).ajaxStart(function(){
    $(".sk-circle").show();
  });

  // hide sk-circle on AJAX stop
  $(document).ajaxStop(function(){
    $(".sk-circle").hide();
  });

});
