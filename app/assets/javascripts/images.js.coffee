$(document).ready ->
  # Basic thumbnail scrolling
  
  totalWidth = 0 # Get total width of all thumbnails
  
  $(".items").children().each ->
    totalWidth = totalWidth + $(this).outerWidth(true)

  $(".items").css "width", parseInt(totalWidth) + "px"
