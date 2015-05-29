$.srSmoothscroll
  step: 100
  speed: 100
  ease: 'swing'
  target: $('body')
  container: $(window)

smoothScroll.init
  updateURL: false
  offset: 20

$(document).scroll ->
  top = $(document).scrollTop()

  $('#main-image').css('top', top/3);

  $('#main-image h1').css('padding-top', 200+top/5);

  $('#sub-header').css('top', top/2);

  # opacity = top/600;

  # if top > 600
  #   opacity = 1;

  # $('#top-nav').css('background-color', "rgba(240, 240, 240, #{opacity})")
  #$('#top-nav').css('background-color', "rgba(51, 51, 74, #{opacity})")



$(window).bind 'hashchange', ->
  navigate()

toProject = ->
  $('#main-image').height(400)
  $('#main-image').removeClass('home-image').addClass('project-image')
  $('.nav-element a').removeClass('active')

  $('.project-specific')
  .show()

  $('.home-specific')
  .hide()

  $(document).scrollTop(0)

toHome = ->
  $('#main-image').height(600)
  $('#main-image').removeClass('project-image').addClass('home-image')
  $('.nav-element a').removeClass('active')
  $('.about-link').addClass('active')

  $('.home-specific')
  .show()

  $('.project-specific')
  .hide()

  $(document).scrollTop(0)

navigate = ->
  toProject() if location.hash is '#project'
  toHome()    if location.hash is ''

$(document).ready ->
  navigate()