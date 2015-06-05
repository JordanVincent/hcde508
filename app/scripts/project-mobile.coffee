$(document).ready ->
  $('.about-link').click (event) ->
    $('#backdrop').fadeIn 400, ->
        window.toHome()
        $('#backdrop').fadeOut 400

  $('.project').click (event) ->

    unless window.isMobile
      return $('#backdrop').fadeIn 400, ->
        window.toProject()
        $('#backdrop').fadeOut 400

    $project = $(event.currentTarget)

    # snatch
    #$('.project').not($project).find('.project-inner').css('opacity', 0)
    $projectSnatcher = $($project.bodysnatch())
    $projectSnatcher.find('p').animate({opacity: 0})
    $projectSnatcher.css('z-index', 30)
    $('#backdrop').fadeIn 400, ->
      $('.snatched').css({visibility: 'visible'})

      # move
      scroll = $(document).scrollTop()
      top = $projectSnatcher.position().top
      $projectSnatcher.css('top', top-scroll)
      $(document).scrollTop(0)
      window.toProject()

      top = window.mainImageHeight + $('.project-logo').position().top
      $projectSnatcher.animate({top: top})

      $projectSnatcher.find('img').css({position: 'relative'})
      $projectSnatcher.find('img').animate
        width: 135
        padding: 0
        height: 135
        'max-height': 135
        'max-width': 135
        top: -37
        left: -22

      $projectSnatcher.find('.text-inner').css
        width: '62%'
      $projectSnatcher.find('.caption').css
        width: 120

      $projectSnatcher.find('h3').css({'font-family': 'MyriadProBlack'})
      $projectSnatcher.find('h3').animate
        'font-size': '3.5em'
      , 400, 'swing', ->
        $('#backdrop').add($projectSnatcher).fadeOut()

  $('.disabled-link').click ->
    $('#disabledInfo').fadeIn().delay(3000).fadeOut()