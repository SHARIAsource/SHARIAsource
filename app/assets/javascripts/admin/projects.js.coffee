# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  $('#project_user_ids').change ->
    if $('.project_user_'+ @options[event.target.getAttribute('data-option-array-index')].value)[0]
       $('.project_user_'+ @options[event.target.getAttribute('data-option-array-index')].value).remove()
    $('form').submit()
    return

$(document).ready(ready)
$(document).on('turbolinks:load', ready)
