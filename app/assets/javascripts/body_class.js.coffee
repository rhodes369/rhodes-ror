$(document).ready ->
  title = $("h3#mat_title").text().replace(RegExp(" ", "g"), "")
  $("body").addClass title