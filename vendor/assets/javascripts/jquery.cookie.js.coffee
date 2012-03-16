# This code is originally taken from the jQuery Cookie plugin by carhartl
# http://plugins.jquery.com/node/1387
# 
# Rewritten in CoffeeScript by Bodacious on 23rd June 2011 for http://urtv.co.uk
jQuery.cookie = (name, value, options) ->
  if typeof value != 'undefined'
    options = options || {}
    if value == null
      value = "" 
      options.expires = -1
    expires = ""
    if options.expires and (typeof options.expires == 'number' or options.expires.toUTCString)
      if typeof options.expires == "number"
        date = new Date
        date.setTime(date.getTime() + (options.expires * 24 * 60 * 60 * 1000))
      else
        date = options.expires
      # use expires attribute, max-age is not supported by IE
      expires = "; expires=#{date.toUTCString()}" 
    path = if options.path then "; path=#{(options.path)}" else ""
    domain = if options.domain then "; domain=#{options.domain}" else ""
    secure = if options.secure then "; secure=#{options.secure}" else ""
    document.cookie = [name, "=", encodeURIComponent(value), expires, path, domain, secure].join("")
  else # only name given, get cookie
    cookieValue = null
    if document.cookie and document.cookie != ""
      cookies = document.cookie.split(";")
      for cookie in cookies
        cookie = jQuery.trim(cookie)
        if cookie.substring(0, (name.length + 1)) == ("#{name}=")
          cookieValue = decodeURIComponent(cookie.substring(name.length + 1))
          break
    # return the value of cookieValue
    cookieValue