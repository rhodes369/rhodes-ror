# window.App or= {}
# 
# class App.FlashMessages
#   constructor: (@globalAlert) ->
#     log 'construct'
#     log @globalAlert
#     @setAlertTimeout()
# 
#   fadeOutAlert: (@speed = 500) -> 
#     log 'fadeOutAlert'
#     @globalAlert.fadeOut(@speed).remove()
#       
#   # setAlertTimeout: ->
#   #   log 'setAlertTimeOut'
#   #   setTimeout( @fadeOutAlert(3000), 7000)
#     
#   setAlertTimeout: ->
#     setTimeout( -> 
#       @fadeOutAlert(3000), 5000)
#     )   
# 
# 
# 
# $(document).ready ->
#   
#   log 'flash_alerts js loaded'
#   globalAlert = $('#globalAlert')
#   
#   $('#globalAlert').on(
#     click: ->
#       $(this).fadeOut(1000)
#       $(this).remove()
#   )  
#   
#   flashMessage = new window.App.FlashMessages(globalAlert)



  # $('#globalAlert').click ->
  #   $(this).remove()
  #   log 'globalAlert click'
    


  # setupTimer: ->
  #   log 'setupTimer'
  #   setTimeout(@removeAlert(), 1000)

  