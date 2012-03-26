# Toggle Menu

$(document).ready ->
  $("#content-left ul > li > a.expanded + ul").slideToggle "medium"
  $("#content-left ul > li > a").click ->
    $(this).toggleClass("expanded").toggleClass("collapsed").find("+ ul").slideToggle "medium"
