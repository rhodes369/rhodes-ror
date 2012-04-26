# Toggle Menu

$(document).ready ->
  $("#content-left ul > li > a.closed + ul").slideToggle "medium"
  $("#content-left ul > li > a").click ->
    $(this).toggleClass("closed").toggleClass("open").find("+ ul").slideToggle "medium"
