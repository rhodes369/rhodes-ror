$(document).ready ->

  $('#globalAlert').click ->
    $(this).remove()
 
  # setupTimer
    setTimeout(removeAlert, 7000)

 removeAlert: -> 
  $('#globalAlert').fadeOut('500', => $(this).remove())