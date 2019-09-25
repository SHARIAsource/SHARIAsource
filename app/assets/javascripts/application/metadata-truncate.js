(function() {
  var max = 148;

  var hideOverlaps = function() {
    var metadata = $('.metadata')[0];

    if(metadata !== null && metadata !== undefined) {
      var mainBox = metadata.getBoundingClientRect();
      var bottom = mainBox.top + mainBox.height;

      $('.metadata *:not(:has(*)), .metadata li').each((_, el) => {
        var box = el.getBoundingClientRect();
        var itemBottom = box.top + box.height;

        if( itemBottom > bottom) {
          $(el).hide().addClass('item-hidden');
        }
      });
    }

    $('.meta-show-more').show();
    $('.meta-show-less').hide();

    return false;
  };

  $(document).on('turbolinks:load', function() {
    $('.metadata').height(max);
    setTimeout(hideOverlaps, 500);
    return false;
  });

  $(document).on('click', '.meta-show-more', function() {
    $('.metadata').height('auto');
    $('.metadata .item-hidden').show().removeClass('item-hidden');

    $('.meta-show-more').hide();
    $('.meta-show-less').show();

    return false;
  });

  $(document).on('click', '.meta-show-less', function() {
    $('.metadata').height(max);
    setTimeout(hideOverlaps, 1);
    return false;
  });
}())

