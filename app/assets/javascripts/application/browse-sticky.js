(function() {
  $(document).on('turbolinks:load', function() {
    var $table = $('.browse-table-stick')
    var $topLevels = $table.find('tr[data-depth=0]')

    $table.waypoint('destroy').waypoint(function(direction) {
      $('.browse-headings-sticky').toggleClass('showing', direction === 'down')
    })

    $table.waypoint(function(direction) {
      $('.browse-headings-sticky').toggleClass('showing', direction === 'up')
    }, {
      offset: function() {
        return -$table.outerHeight() + $table.find('.browse-headings').height()
      }
    })

    $topLevels.waypoint('destroy').waypoint(function(direction) {
      var $active = $(this)
      var html = '&nbsp;'

      if (direction === 'up') {
        $active = $active.waypoint('prev')
      }

      if ($active.data('depth') === 0) {
        html = $active.find('th:first-child').html()
      }

      $('.browse-headings-sticky th:first-child').html(html)
    }, {
      offset: function() {
        return $table.find('.browse-headings').height() - $(this).height()
      }
    })
  })
}())
