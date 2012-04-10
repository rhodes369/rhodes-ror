@App = window.App ? {} # set App in global namespace to attach global methods to

# this global method replaces console.log() with just log() since console.log() as it 
# can break some browsers wihtout firebug and should go @ the top the public 
# application.js manifest file - thanx Duke
# note we don't want to attach this to the App, so we don't have to type App.log everytime
window.log = (msg) -> console.log(msg) if console?