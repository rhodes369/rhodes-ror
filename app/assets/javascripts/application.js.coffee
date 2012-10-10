# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
#
# WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
# GO AFTER THE REQUIRES BELOW.
#
#
#= require jquery
#= require jquery_ujs
#= require underscore
#= require backbone
#= require backbone_rails_sync
#= require backbone_datalink
#
#= require_self
#= require_tree ../templates/
#= require_tree .//models
#= require_tree .//collections
#= require_tree .//views
#= require_tree .//routers
#= require images
#= require left_side_bar
#= require materials
#= require toggle
#= require body_class
### Vendor ###
#= require jquery-tools_no-jq.1.2.7
#= require thumb_scroll
#= require dropdown
#= require jquery.cookie
#= require toggle_menu

@App = 
  dispatcher: _.clone(Backbone.Events)
  vars: {}
  Admin: 
    Materials: 
      Edit: {}
    
$(document).ready ->
  adminRouter = new AdminRouter()
  Backbone.history.start({pushState: true})

# this global method replaces console.log() with just log() 
# the console object is not defined in all browsers and thus will throw an error if a console.log statement is forgotten in the code.
window.log = (msg) -> console.log(msg) if console?
