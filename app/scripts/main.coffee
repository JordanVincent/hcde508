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
    navTop = if isMobile then -50 else -70
    navOpacity = 0

  $('.top-nav.sticky').css
    top: navTop
    opacity: navOpacity

  $('.top-nav-mobile').css
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

setupMenuAnimation = ->
  speed = 500
  easing = mina.easeinout

  el = $('.top-nav-mobile')

  s = Snap(el.find('svg')[0])
  path = s.select('path')

  return unless path
  pathConfig =
    from: path.attr( 'd' )
    to: el.attr('data-path-click')

  el.click ->
    isOpen = el.hasClass('open')
    pathType = if isOpen then pathConfig.from else pathConfig.to
    if isOpen
      el.find('.inner').removeClass('open')
      el.animate { 'background-color': 'rgba(255, 255, 255, 0)'}, speed
      path.animate { 'path' : pathType }, speed, easing, ->
        el.removeClass('open')
        el.find('ul').hide()
        el.find('svg').hide()
    else
      el.find('svg').show()
      el.find('ul').show()
      el.find('.inner').addClass('open')
      el.addClass('open')
      el.animate { 'background-color': 'rgba(255, 255, 255, 0.8)'}, speed
      path.animate { 'path' : pathType }, speed, easing

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
  return toProject() if location.hash is '#project'
  toHome()

checkIsMobile = ->
  isMobile = $(window).width() <= 480

setupCard = ->
  speed = 500

  $('#footerImage').click ->
    $('#cardSection').fadeIn().css('display', 'flex');

  $('#cardSection .close').click ->
    $('#cardSection').fadeOut()

  $('#card3dBtn').click ->
    $('#card3dBtn').toggleClass('active')
    $('#cardSection .card').toggleClass('built')
    $shadow = $('#cardSection .shadow')
    if $shadow.is(':visible') then $shadow.fadeOut(speed) else $shadow.fadeIn(speed)

$(window).resize ->
  checkIsMobile()

$(document).ready ->
  navigate()
  setupProjectAnimations()
  setupMenuAnimation()
  checkIsMobile()
  setupCard()