$(document).ready ->
  
  # Basic thumbnail scrolling
  
  totalWidth = 0 # Get total width of all thumbnails
  
  $("#thumbs, .items").children().each ->
    totalWidth = totalWidth + $(this).outerWidth(true)

  $("#thumbs, .items").css "width", parseInt(totalWidth) + "px"
