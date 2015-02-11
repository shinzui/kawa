var address, output, page, system;

page = require('webpage').create();

system = require('system');

if (system.args.length < 2 || system.args.length > 3) {
  console.log("Usage: phantom screenshot_grabber.coffee URL filename");
  phantom.exit(1);
} else {
  address = system.args[1];
  output = system.args[2];
  page.viewportSize = {
    width: 1280,
    height: 1024
  };
  page.javascriptEnabled = true;
  page.settings.localToRemoteUrlAccessEnabled = true;
  page.settings.webSecurityEnabled = true;
  page.settings.XSSAuditingEnabled = true;
  page.onError = function(msg, trace) {
    return system.stderr.writeLine(msg);
  };
  page.onResourceError = function(resourceError) {
    system.stderr.writeLine("  - unable to load url: " + resourceError.url);
    return system.stderr.writeLine("  - error code: " + resourceError.errorCode + " description: " + resourceError.errorString);
  };
  page.open(address, function(status) {
    if (status !== "success") {
      console.log("Unable to load address " + address + ": " + status);
      return phantom.exit(1);
    } else {
      return window.setTimeout(function() {
        page.clipRect = {
          top: 0,
          left: 0,
          width: 1280,
          height: 1024
        };
        page.render(output);
        return phantom.exit();
      }, 5000);
    }
  });
}

