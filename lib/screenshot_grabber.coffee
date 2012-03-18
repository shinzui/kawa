page = new WebPage()
if phantom.args.length < 2 or phantom.args.length > 3
  console.log "Usage: phantom screenshot_grabber.coffee URL filename"
  phantom.exit(1)
else
  address = phantom.args[0]
  output = phantom.args[1]
  page.viewportSize = { width : 1024, height : 768 }
  page.open(address, (status) ->
    if status isnt "success"
      console.log "Unable to load address #{address}: #{status}"
      phantom.exit(1)
    else
      window.setTimeout ->
        page.clipRect = { top : 0, left : 0, width : 1024, height: 768}
        page.render(output)
        phantom.exit()
      , 200)
