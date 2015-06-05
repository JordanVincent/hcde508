# Thanks https://gist.github.com/franzenzenhofer/4051578

(($) ->

  isString = (obj) ->
    toString.call(obj) == '[object String]'

  $.fn.bodysnatch = ->
    collection = this
    collection.each (a, b) ->
      element = $(this)
      clone = element.clone()
      w = element.width()
      h = element.height()
      if w and h
        clone.attr 'style', window.getComputedStyle(element[0]).cssText
        clone.css
          position: 'absolute'
          top: element.offset().top
          left: element.offset().left
          width: element.width()
          height: element.height()
          margin: 0
      else
        clone.css
          position: 'absolute'
          top: element.offset().top
          left: element.offset().left
          margin: 0
      $('body').append clone
      if element[0].id
        element[0].id = element[0].id + '_snatched'
      element.addClass 'snatched'
      clone.addClass 'bodysnatcher'
      #stop audio and videos
      element.css 'visibility', 'hidden'
      if element[0].pause
        element[0].pause()
        element[0].src = ''
      collection[a] = clone[0]
      return

  return
) jQuery