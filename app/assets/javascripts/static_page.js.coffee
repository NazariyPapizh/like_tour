# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $('.g-map-wrap .drop-down-map').click ->
    $('.g-map-wrap #g-map').toggleClass('expand')
    if $(this).hasClass('expand')
      $(this).removeClass('expand')
    else
      $(this).addClass('expand')

#   about photo banner
  $('ul.about-image-banner').bxSlider
#    mode: 'fade'
    controls: false
#    auto: true
    pause: 6000
    pagerCustom: 'ul#about-thumbnails'

#    publication banner
  $('ul.publications-banner').bxSlider
#    mode: 'fade'
    controls: false
#    auto: true
    pause: 6000
    pagerCustom: 'ul.publications-pagers-preview'
