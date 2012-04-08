# this global method replaces console.log() with just log() since console.log() as it 
# can break some browsers wihtout firebug and should go @ the top the public 
# application.js manifest file - thanx Duke
window.log = (msg) -> console.log(msg) if console?
