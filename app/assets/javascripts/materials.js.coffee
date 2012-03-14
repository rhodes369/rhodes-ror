# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->

  $('#globalAlert').click ->
    $(this).remove()
 
  # setupTimer
    setTimeout(removeAlert, 7000)

 removeAlert = -> 
  $('#globalAlert').fadeOut('500', => $(this).remove())
