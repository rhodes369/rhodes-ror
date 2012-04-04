$(document).ready ->
  title = $("h3#mat_title").text().replace(RegExp(" ", "g"), "")
  $("body").addClass title
  # 
  # $("body").filter(->
  #   @className.match(/^Antique/)?
  # ).each ->
  #   $("ul#antiques").css "display", "block"