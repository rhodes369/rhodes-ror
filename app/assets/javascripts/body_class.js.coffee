$(document).ready ->


  # Add class to body based on h3#mat_title
  title = $("#mat_title").text().replace(RegExp(" ", "g"), "")
  $("body").addClass title
  
  
  # Check if Antique is in the class name on body and show / hide menus
  $("body").filter(->
    @className.match(/^Antique/)?
  ).each ->
    $("ul#antiques").css "display", "block"
    $("ul#newly").css "display", "none"








  # title = $("#mat_title").text().replace(RegExp(" ", "g"), "")
  # $("body").addClass title
  # antique = $("body").filter(->
  #   @className.match /^Antique/
  # )
  # if antique
  #   $("ul#antiques").css "display", "block"
  #   $("ul#newly").css "display", "none"
  # else
  #   $("ul#antiques").css "display", "none"
  #   $("ul#newly").css "display", "block"
