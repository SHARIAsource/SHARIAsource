(function() {
  var max = 148;

  $(document).on('turbolinks:load', function() {
    var metadata = $('.metadata')[0];
    if(metadata !== null && metadata !== undefined) {
      var maxChild = Math.max.apply(null, Array.from(metadata.children).map(col => Math.max.apply(null, Array.from(col.children).map(el => el.offsetHeight))));
      if(max > maxChild) {
        $('.meta-show-more, .meta-show-less').hide();
      }
      else {
        $('.meta-column').css('max-height', max + 'px');
      }
    }
  }).on('click', '.meta-show-more', function(event) {
    $(event.target).parents('.metadata').css('max-height', 'none');
    $(event.target).parents('.metadata').find('.meta-column').css('max-height', 'none');
    $(event.target).parents('.metadata').find('.meta-show-less').show();
    $(event.target).hide();
    $(document).trigger('sameheight:refresh');
    event.preventDefault()

  }).on('click', '.meta-show-less', function(event) {
    $(event.target).parents('.metadata').css('max-height', max + 'px');
    $(event.target).parents('.metadata').find('.meta-column').css('max-height', max + 'px');
    $(event.target).parents('.metadata').find('.meta-show-more').show();
    $(event.target).hide();
    $(document).trigger('sameheight:refresh');
    event.preventDefault()
  })
}())

