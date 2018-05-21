(function() {
  $(document).on('turbolinks:load', function() {
    // ...
  }).on('click', '.meta-show-more', function(event) {
    $(event.target).parents('.metadata').css('max-height', 'none');
    $(event.target).parents('.metadata').find('.meta-show-less').show();
    $(event.target).hide();
    $(document).trigger('sameheight:refresh');
    event.preventDefault()

  }).on('click', '.meta-show-less', function(event) {
    $(event.target).parents('.metadata').css('max-height', '142px');
    $(event.target).parents('.metadata').find('.meta-show-more').show();
    $(event.target).hide();
    $(document).trigger('sameheight:refresh');
    event.preventDefault()
  })
}())

