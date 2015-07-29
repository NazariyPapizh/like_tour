# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "click", ".select-category .fancy-select ul.options li", ->
  $value = $(this).attr "data-raw-value"
  console.log('category:', $value)
  valuesToSubmit = {category: $value}
  $.ajax
    url: '/get_cities_from_category'
    type: "GET"
    dataType: "json"
    data: valuesToSubmit
    beforeSend: ->
#      alert 'start send'+valuesToSubmit+$value
    success: (data) ->
      $select = $('.select-city select')
      $select.children().remove()
      options = data
      $.each options, (index, obj) ->
        $(".select-city select").append '<option value="'+obj.slug+'" name="type" >' + obj.name + "</option>"
      $select.trigger("update.fs")
    complete: ->
      $.ajax
        url: '/get_filters_from_category_c'
        type: "GET"
        data: valuesToSubmit
        dataType: 'json'
        beforeSend: ->
        success: (data) ->
          $filterWrap = $('ul.main-banner-filters')
          $filterWrap.children().remove()
          $.each data, (index, obj) ->
            $filterWrap.append "<li><div class='squared-checkbox'><input id='squared-zimovi-"+index+"-form' name='check' type='checkbox' value="+obj.slug+"><label class='ico' for='squared-zimovi-"+index+"-form'></label></div><label class='text' for='squared-zimovi-"+index+"-form'>"+obj.name+"</label></li>"
        complete: ->


$(document).on "click", ".select-city .fancy-select ul.options li", ->
  $parent = $(this).closest('.form')
  $category = $parent.find('.select-category option:selected').val()
  console.log('category:', $category)
  $value = $(this).attr "data-raw-value"
  console.log('city:', $value)
  valuesToSubmit = {category: $category ,city: $value}
  $.ajax
    url: '/get_filters_from_category'
    type: "GET"
    dataType: "json"
    data: valuesToSubmit
    beforeSend: ->
    success: (data) ->
      $filterWrap = $('ul.main-banner-filters')
      $filterWrap.children().remove()
#      w = data
#      filters = w.split(',')
      $.each data, (index, obj) ->
        $filterWrap.append "<li><div class='squared-checkbox'><input id='squared-zimovi-"+index+"-form' name='check' type='checkbox' value="+obj.slug+"><label class='ico' for='squared-zimovi-"+index+"-form'></label></div><label class='text' for='squared-zimovi-"+index+"-form'>"+obj.name+"</label></li>"
      $select.trigger("update.fs")
    complete: ->

$(document).ready ->
  fancySelect = $('.fancy-select')
  fancySelect.fancySelect()
  fancySelect.trigger('update')
  $(".select-category select").change ->
    alert $(this).val()

#  bx slider for one event header page
  $('ul.page-header-slides').bxSlider
#    mode: 'fade'
    controls: false
    auto: true
    pause: 6000
    pagerCustom: 'ul.event-banner-thumbnails'
    responsive: true
