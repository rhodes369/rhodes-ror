# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/




# Basic thumbnail scrolling
$(document).ready ->

  # Get total width of all thumbnails
  totalWidth = 0
  $(".gallery-thumbs form").children().each ->
    totalWidth = totalWidth + $(this).outerWidth(true)

  $(".gallery-thumbs").css "width", parseInt(totalWidth) + "px"


  $(".next").click ->
      scrollAmount = $(".gallery-thumbs").width() - $(".gallery-thumbs").parent().width()
      currentPos = Math.abs(parseInt($(".gallery-thumbs").css("left")))
      remainingScroll = scrollAmount - currentPos
      nextScroll = Math.floor($(".gallery-thumbs").parent().width())
      nextScroll = remainingScroll  if remainingScroll < nextScroll
      if currentPos < scrollAmount
        $(".gallery-thumbs").animate
          left: "-=" + nextScroll
        , "slow"
      else
        $(".gallery-thumbs").animate
          left: "0"
        , "fast"


  # $(".prev").click ->
  #     scrollAmount = $(".items").width() - $(".items").parent().width()
  #     currentPos = Math.abs(parseInt($(".items").css("left")))
  #     remainingScroll = scrollAmount - currentPos
  #     prevScroll = Math.floor($(".items").parent().width())
  #     prevScroll = remainingScroll  if remainingScroll < prevScroll
  #     if currentPos < scrollAmount
  #       $(".items").animate
  #         left: "+=" + prevScroll
  #       , "slow"
  #     else
  #       $(".items").animate
  #         right: "0"
  #       , "fast"












