page = require('webpage').create()
system = require('system')

if phantom.args.length < 2 or phantom.args.length > 3
  console.log "Usage: phantom screenshot_grabber.coffee URL filename"
  phantom.exit(1)
else
  address = phantom.args[0]
  output = phantom.args[1]
  page.viewportSize = { width : 1280, height : 1024 }
  page.javascriptEnabled = true
  page.settings.localToRemoteUrlAccessEnabled = true
  page.settings.webSecurityEnabled = true
  page.settings.XSSAuditingEnabled = true
  page.onError = (msg, trace) ->
    system.stderr.writeLine msg
  page.onResourceError = (resourceError) ->
      system.stderr.writeLine "  - unable to load url: #{resourceError.url}"
      system.stderr.writeLine "  - error code: #{resourceError.errorCode} description: #{resourceError.errorString}"
  page.open(address, (status) ->
    if status isnt "success"
      console.log "Unable to load address #{address}: #{status}"
      phantom.exit(1)
    else
      window.setTimeout ->
        page.clipRect = { top : 0, left : 0, width : 1280, height: 1024}
        page.render(output)
        phantom.exit()
      , 5000)
