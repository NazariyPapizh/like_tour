# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# bind for main menu
$(document).on "click", '.header-wrap .button-open-main-menu', ->
  $currentElement = $(this)
  parentElement = $currentElement.closest('.header-wrap')

  if $currentElement.hasClass('link-to-main-menu')
    if $('.link-to-contacts-menu').hasClass('active')
      $('.link-to-contacts-menu').removeClass('active')
      if parentElement.hasClass('expand')
        parentElement.removeClass('expand')
    if $('.link-to-main-menu').hasClass('active')
      $('.link-to-main-menu').removeClass('active')
      if parentElement.hasClass('expand')
        parentElement.removeClass('expand')
    else
      $('.link-to-main-menu').addClass('active')
      parentElement.addClass('expand')

    if $('#main-menu').hasClass('hide')
      $('#contacts-menu').addClass('hide')
      $('#main-menu').removeClass('hide')

  if $currentElement.hasClass('link-to-contacts-menu')
    if $('.link-to-main-menu').hasClass('active')
      $('.link-to-main-menu').removeClass('active')
      if parentElement.hasClass('expand')
        parentElement.removeClass('expand')
    if $('.link-to-contacts-menu').hasClass('active')
      $('.link-to-contacts-menu').removeClass('active')
      if parentElement.hasClass('expand')
        parentElement.removeClass('expand')
    else
      $('.link-to-contacts-menu').addClass('active')
      parentElement.addClass('expand')

    if $('#contacts-menu').hasClass('hide')
      $('#main-menu').addClass('hide')
      $('#contacts-menu').removeClass('hide')


countTourInCategory = ($this) ->
  $page = $this.closest('.page-wrap')
  $tours = $page.find('.one-event-wrap')
  alert $tours.size()

toggleFiltersClass = ($this) ->
  $filter = $this.closest('li')
  if $filter.hasClass('active')
    $filter.removeClass('active')
  else
    $filter.addClass('active')



$(document).ready ->
  $FiltersSelector = $('.category-with-city-wrap .filters-main input')
  filters = []
  $container = $('.category-with-city-wrap .tours-container')

  $FiltersSelector.filter(":checked").each ->
    filters.push @value
  filters = filters.join(", ")

  console.log("filters:", filters)

  $container.imagesLoaded ->
    $container.isotope
      itemSelector: '.category-with-city-wrap .item-filter'
      layoutMode: 'fitRows'
      filter: filters


# binder for main filters change
  $('.filters-main input').change ->
    filters = []
    $this = $(this)
    $parent = $this.closest('.filter-wrap')
    $checkboxes = $parent.find('input')
    $container = $parent.find('.container-main')
    $item = $container.find('.item-filter')

    $container.isotope itemSelector: $item

    # get checked checkboxes values
    $checkboxes.filter(":checked").each ->
      filters.push @value

    filters = filters.join(", ")
    $container.isotope filter: filters

# init fancybox
  $("a.fancybox").fancybox
    padding: 0
    width: '100%'
    closeBtn : false
    tpl:
      wrap: "<div id=\"popup-wrapper\" class=\"fancybox-wrap popup-wrap\" tabIndex=\"-1\"><div class=\"fancybox-skin\"><div class=\"fancybox-outer\"><div class=\"fancybox-inner\"></div></div></div></div>"
  $("a.close-form").click (e) ->
    e.preventDefault()
    $.fancybox.close()

#  binder for switcher language
  $('li.active_language').click ->
    $this = $(this)
    if $this.hasClass('expand')
      $this.removeClass('expand')
    else
      $this.addClass('expand')

#  focusout on switcher language
  $('ul.sub-menu-switcher').focusout ->
    $wrap = $(this).closest('.language-switcher-wrap')
    $obj = $wrap.find('li.active_language')
    if $obj.hasClass('expand')
      $obj.removeClass('expand')

# social links
  $('.share-links-wrap .icon').click ->
    $parent = $(this).closest('.inner')
    if $parent.hasClass('active')
      $parent.removeClass('active')
    else
      $parent.addClass('active')

# init index page region carousel
  owl1 = $("ul.owl-carousel")
  owl1.owlCarousel
    pagination: false,
    navigation: false,
#    navigationText: [
#      '<%= ApplicationHelper.embedded_svg_js "MO-arrow.svg", class: "owl_arrow_prev"%>',
#      '<%= ApplicationHelper.embedded_svg_js "MO-arrow.svg", class: "owl_arrow_next"%>'
#    ],
    items: 6 #10 items above 1000px browser width
    itemsDesktop: [ #5 items between 1000px and 901px
      1000
      5
    ]
    itemsDesktopSmall: [ # betweem 900px and 601px
      900
      4
    ]
    itemsTablet: [ #2 items between 600 and 0
      780
      3
    ]
    itemsMobile: false # itemsMobile disabled - inherit from itemsTablet option
    autoPlay : false


# init index page partners carousel
  owl2 = $(".partners-wrap ul")
  owl2.owlCarousel
    pagination: false,
    navigation: false,
#    navigationText: [
#      '<%= ApplicationHelper.embedded_svg_js "MO-arrow.svg", class: "owl_arrow_prev"%>',
#      '<%= ApplicationHelper.embedded_svg_js "MO-arrow.svg", class: "owl_arrow_next"%>'
#    ],
    items: 5 #10 items above 1000px browser width
    itemsDesktop: [ #5 items between 1000px and 901px
      1000
      5
    ]
    itemsDesktopSmall: [ # betweem 900px and 601px
      900
      4
    ]
    itemsTablet: [ #2 items between 600 and 0
      780
      3
    ]
    itemsMobile: false # itemsMobile disabled - inherit from itemsTablet option
    autoPlay : false

#  init index page tabs
  $('.index-tour-tabs-wrap ul li').click ->
    current_position = $(this).index()
    $head_tabs = $(this).closest('.index-tour-tabs-wrap')
    $head_tabs_li = $head_tabs.find('li')
    $head_tabs_li.children().removeClass('active')
    $(this).children().first().addClass('active')
    $body_tabs_li = $('.index-tour-tabs-pages-wrap').find('.index-tour-page')
    $body_tabs_li.removeClass('active').addClass('hide')
    $body_tabs_li.eq(current_position).addClass('active').removeClass('hide')

# declare global
slider_array = new Array()
jQuery(document).ready ($) ->

  # launch bxslider
  a = {
    controls: true
    pause: 6000
#    auto: true
    pagerCustom: '#custom-thumbnails'
    responsive: true
  }

  b = {
    controls: false
    pause: 6000
#    auto: true
    pagerCustom: '#custom-thumbnails'
    responsive: true
  }

  $(".bxslider").each (i) ->
    if $(this).hasClass('first-main-banner')
      slider_array[i] = $(this).eq(0).bxSlider(a)
    else if $(this).hasClass('second-main-banner')
      slider_array[i] = $(this).eq(0).bxSlider(b)

  # bind controls on custom controls, and run functions on every slider
  $(".bx-controls-direction a").bind "click", (e) ->
    e.preventDefault()
    if $(this).hasClass("bx-prev")
      $.each slider_array, (i, elem) ->
        elem.goToPrevSlide()

    else if $(this).hasClass("bx-next")
      $.each slider_array, (i, elem) ->
        elem.goToNextSlide()

#        order event form
  $('.wrap-for-sending-form form').submit (event) ->
  # Stop the browser from submitting the form.
    event.preventDefault()
  # Serialize the form data.
    $wrapper = $(this).closest('.wrap-for-sending-form')
    $statusWindow = $wrapper.find('.sending-status-wrap')
    $loading = $statusWindow.find('.sending-wrap')
    $succes = $statusWindow.find('.success-wrap')

    $thisForm = $(this).closest('form')

    formData = $thisForm.serialize()
  # Submit the form using AJAX.
    $.ajax
      type: "POST"
      url: $thisForm.attr("action")
      data: formData
      beforeSend: ->
        $statusWindow.removeClass('hide')
      success: ->
        $loading.addClass('hide')
        $succes.removeClass('hide')
      complete: ->
        setTimeout (->
          $thisForm.find("input[type=text],input[type=email], textarea").val("")
        ), 3000
      error: ->
        alert "Something went wrong!"




  $('.close-modal-button').click ->
    $statusWrap = $(this).closest('.sending-status-wrap')
    $sendingWrap = $statusWrap.find('.sending-wrap')

    $modalWrap = $(this).closest('.success-wrap')

    $wrapper = $(this).closest('.order-event-form-wrap')
    $thisForm = $wrapper.find('form')

    $statusWrap.addClass('hide')
    $sendingWrap.removeClass('hide')
    $modalWrap.addClass('hide')














