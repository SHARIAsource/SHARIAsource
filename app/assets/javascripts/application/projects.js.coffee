# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'ready page:load', ->

  $('.pagination').hide()
  $('.ss-button').on 'click', (event) ->
    $('.next_page').click()
    return

  $('.contributor-search').on 'click', $('.next_page'), (event) ->
    event.preventDefault()
    $.ajax
      url: $('.next_page')[0].href 
      success: (res) ->
        search_results = res.indexOf('<div class="search-results">')
        footer_div = res.indexOf('<div class="inner-wrapper"><div class="footer">')
        $(".search-results").replaceWith(res.substring(search_results, footer_div));
        $('.pagination').hide()
        window.history.pushState('','', this.url)
        return false

  $('#all_named_search').on 'click', (event) ->
    check_boxes = $('.additional_search')
    i = 0
    filter_ids = []
    while i < check_boxes.length
      check_boxes[i].checked = true
      filter_ids.push check_boxes[i].value
      i++
    $.ajax
     data: 
      named_filter_id: filter_ids
     url: '/projects/' + this.value
     success: (res) ->
       search_results = res.indexOf('<div class="search-results">')
       footer_div = res.indexOf('<div class="inner-wrapper"><div class="footer">')
       $(".search-results").replaceWith(res.substring(search_results, footer_div));
       return

  $('.additional_search').on 'click', (event) ->
    check_boxes = $('.additional_search')
    checked_boxes = []
    i = 0
    while i < check_boxes.length
      if check_boxes[i].checked
        checked_boxes.push check_boxes[i]
      i++
    filter_ids = []
    i = 0
    while i < checked_boxes.length
      filter_ids.push checked_boxes[i].value
      i++
    if checked_boxes.length < 1
      $.ajax
        url: '/projects/' + this.id
        success: (res) ->
          search_results = res.indexOf('<div class="search-results">')
          footer_div = res.indexOf('<div class="inner-wrapper"><div class="footer">')
          $(".search-results").replaceWith(res.substring(search_results, footer_div));
          return
    else
      $.ajax
        data: 
         named_filter_id: filter_ids
        url: '/projects/' + this.id
        success: (res) ->
          search_results = res.indexOf('<div class="search-results">')
          footer_div = res.indexOf('<div class="inner-wrapper"><div class="footer">')
          $(".search-results").replaceWith(res.substring(search_results, footer_div));
          return
  return

