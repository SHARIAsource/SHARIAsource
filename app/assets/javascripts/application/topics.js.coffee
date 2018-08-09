ready = ->
  $('.show-hide-visuals').click ->
    $('.viz-title, .browse-tables svg').toggle()
    if $('.show-hide-visuals').text() == "Text Search Only"
      $('.show-hide-visuals').text("Show Visualizations")
    else
      $('.show-hide-visuals').text("Text Search Only")
    return

$(document).on('turbolinks:load', ready)

