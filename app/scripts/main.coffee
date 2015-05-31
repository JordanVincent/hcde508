isMobile = false

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

  $('#main-image h1').css('padding-top', (if isMobile then 60 else 200) + top/5);

  $('#sub-header').css('top', top/2);

  if top > 600
    navTop = 0
    navOpacity = 1
  else
    navTop = -70
    navOpacity = 0

  $('.top-nav.sticky').css
    top: navTop
    opacity: navOpacity

$(window).bind 'hashchange', ->
  navigate()

setupProjectAnimations = ->
  speed = 250
  easing = mina.easeinout

  $('.project').each (idx, el) ->
    el = $(el)

    s = Snap(el.find('svg')[0])
    path = s.select('path')
    return unless path
    pathConfig =
      from: path.attr( 'd' )
      to: el.attr('data-path-hover')

    el.on 'mouseenter', ->
      path.animate( { 'path' : pathConfig.to }, speed, easing )

    el.on 'mouseleave', ->
      path.animate( { 'path' : pathConfig.from }, speed, easing )

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

checkIsMobile = ->
  isMobile = $(window).width() <= 480

$(window).resize ->
  checkIsMobile()

$(document).ready ->
  navigate()
  setupProjectAnimations()
  checkIsMobile()