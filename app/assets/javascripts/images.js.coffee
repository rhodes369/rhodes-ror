# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/




# Basic thumbnail scrolling
$(document).ready ->

  # Get total width of all thumbnails
  totalWidth = 0
  $(".items form").children().each ->
    totalWidth = totalWidth + $(this).outerWidth(true)

  $(".items").css "width", parseInt(totalWidth) + "px"


  scrollAmount = $(".items").width() - $(".items").parent().width()
  currentPos = Math.abs(parseInt($(".items").css("left")))
  remainingScroll = scrollAmount - currentPos

  # Scroll Next
  $(".next").click ->
    nextScroll = Math.floor($(".items").parent().width() / 2)
    nextScroll = remainingScroll  if remainingScroll < nextScroll
    if currentPos < scrollAmount
      $(".items").animate
        left: "-=" + nextScroll
      , "slow"
    else
      $(".items").animate
        left: "0"
      , "fast"

  # Scroll Previous
  $(".prev").click ->
    prevScroll = Math.floor($(".items").parent().width() / 2)
    prevScroll = remainingScroll  if remainingScroll < prevScroll
    if currentPos < scrollAmount
      $(".items").animate
        left: "+=" + prevScroll
      , "fast"
    else
      $(".items").animate
        left: "0"
      , "fast"






