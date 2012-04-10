# Add "dash" to begining of links in left nav
App.prependLeftSideBarDashes = ->
  if $("#content-left").length > 0
    $("#content-left ul ul li a").prepend "&#8211; " # this needs full hexcode to work -j
