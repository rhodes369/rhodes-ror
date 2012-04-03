# this replaces console.log() with just log() since console.log() can break some browsers
# should go in the public application.js as the first line, then all console.log
# methods replaced - borrowed from old dc code

window.log = (msg) -> console.log(msg) if console?