# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'ready page:load', ->
  $('.pagination').hide()

  # only show part of project description text
  $('.show-less-description').addClass('project-hide') 
  $('.show-more-description').on 'click', (event) ->
     $('.project-description').removeClass('project-description-short')
     $('.show-more-description').addClass('project-hide')
     $('.show-less-description').removeClass('project-hide')
     event.preventDefault()

  $('.show-less-description').on 'click', (event) ->
     $('.project-description').addClass('project-description-short')
     $('.show-more-description').removeClass('project-hide')
     $('.show-less-description').addClass('project-hide')
     event.preventDefault()

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
       window.history.pushState('','', this.url)
       $(".search-results").replaceWith(res.substring(search_results, footer_div));
       $('.pagination').hide()
       return

  # handles pagination for search results
  $('.contributor-search').on 'click', '.ss-button', (event) ->
    event.preventDefault()
    if (event.target.id == "next")
      if $('.next_page')[0] == undefined
           next_page_url = this.href
         else
           next_page_url = $('.next_page')[0].href
    else
      next_page_url = $('.previous_page')[0].href
    $.ajax
      url: next_page_url
      success: (res) ->
        search_results = res.indexOf('<div class="search-results">')
        footer_div = res.indexOf('<div class="inner-wrapper"><div class="footer">')
        $(".search-results").replaceWith(res.substring(search_results, footer_div));
        window.history.pushState('','', this.url)
        $('.pagination').hide()
        return false

  # handles selecting collections
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
      window.history.pushState('','', window.location.href.split('?')[0]) 
      location.reload()
      ### TODO implement following Ajax request. Due to the urgency of the projects
          page and how the pagination works with the filters and searches the page
          will now just refresh if all named filters are unselected
      $.ajax
        url: '/projects/' + this.id
        success: (res) ->
          search_results = res.indexOf('<div class="search-results">')
          footer_div = res.indexOf('<div class="inner-wrapper"><div class="footer">')
          window.history.pushState('','', this.url) 
          $(".search-results").replaceWith(res.substring(search_results, footer_div));
          $('.pagination').hide()
          $.ajax
            url: this.url 
            success: (res) ->
              search_sidebar = res.indexOf('<div class="search-sidebar">')
              search_results = res.indexOf('class="search-results">')
              $(".search-sidebar").replaceWith(res.substring(search_sidebar, search_results))
              $(".edit_named_filter").attr('id', 'new_named_filter')
              return
      ###
    else
      $.ajax
        data: 
         named_filter_id: filter_ids
        url: '/projects/' + $('#project_id').val()
        success: (res) ->
          search_results = res.indexOf('<div class="search-results">')
          footer_div = res.indexOf('<div class="inner-wrapper"><div class="footer">')
          window.history.pushState('','', this.url)
          $(".search-results").replaceWith(res.substring(search_results, footer_div))
          $('.pagination').hide()
          $.ajax
            url: this.url 
            success: (res) ->
              search_sidebar = res.indexOf('<div class="search-sidebar">')
              search_results = res.indexOf('class="search-results">')
              $(".search-sidebar").replaceWith(res.substring(search_sidebar, search_results))
              return
  return
