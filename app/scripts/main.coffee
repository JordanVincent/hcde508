isMobile = false
isHome = true
mainImageHeight = 600

$.srSmoothscroll
  step: 100
  speed: 100
  ease: 'swing'
  target: $('body')
  container: $(window)

smoothScroll.init
  updateURL: false
  offset: 20

updateScroll = ->
  top = $(document).scrollTop()

  $('#main-image').css('top', top/3);

  $('#main-image h1').css('padding-top', (if isMobile then 60 else 200) + top/5);

  $('#sub-header').css('top', top/2);

  if top > mainImageHeight
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

$(document).scroll ->
  updateScroll()

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
  setupMainImageSize()
  $('#main-image').removeClass('home-image').addClass('project-image')
  $('.nav-element a').removeClass('active')

  $('.project-specific')
  .show()

  $('.home-specific')
  .hide()

  $(document).scrollTop(0)

toHome = ->
  setupMainImageSize(true)
  $('#main-image').removeClass('project-image').addClass('home-image')
  $('.nav-element a').removeClass('active')
  $('.about-link').addClass('active')

  $('.home-specific')
  .show()

  $('.project-specific')
  .hide()

  $(document).scrollTop(0)

navigate = ->
  if location.hash is '#project'
    isHome = false
    toProject()
  else
    isHome = true
    toHome()

checkIsMobile = ->
  isMobile = $(window).width() <= 768

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

setupMainImageSize = ->
  windowH = $(window).height()
  height = 400
  if isHome
    height = if windowH > 600 then 600 else windowH

  $('#main-image').height(height)
  mainImageHeight = height

$(window).resize ->
  checkIsMobile()
  updateScroll()
  setupMainImageSize()

$(document).ready ->
  navigate()
  setupProjectAnimations()
  setupMenuAnimation()
  checkIsMobile()
  setupCard()