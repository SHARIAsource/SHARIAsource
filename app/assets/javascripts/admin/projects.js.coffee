# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  $('#project_user_ids').change ->
    ids = $('#project_user_ids').val() || []

    to_remove = $('.project_projects_users_user_id input').filter (i, el) ->
      !ids.includes($(el).val())

    $(el).parent().parent().remove() for el in to_remove
   #$('form').submit()
   #return

$(document).ready(ready)
$(document).on('turbolinks:load', ready)
