# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# the compiled file.
#
# WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
# GO AFTER THE REQUIRES BELOW.
#
#
#= require_self
#= require jquery
#= require jquery_ujs
#= require images
#= require left_side_bar
#= require materials
#= require toggle
#= require body_class
#= require ../../../vendor/assets/javascripts/application

@App = window.App ? {} # set App in global namespace to attach global methods to

# this global method replaces console.log() with just log() 
# the console object is not defined in all browsers and thus will throw an error if a console.log statement is forgotten in the code.
window.log = (msg) -> console.log(msg) if console?