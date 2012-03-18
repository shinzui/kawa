class ScreenshotGrabber
  include Sidekiq::Worker

  Error = Class.new(StandardError)

  def perform(link_id)
    link = Link.find link_id
    generate_screenshot(link)
  end

  def generate_screenshot(link)
    script_location = File.join(Rails.root, 'lib/screenshot_grabber.coffee')
    output = "#{Dir.tmpdir}/#{Digest::MD5.hexdigest(link.url)}.png"
    `phantomjs #{script_location} #{link.url} #{output}`
    if FileTest.exists?(output)
      link.url_screenshot = File.open(output)
      link.save
    else
      raise Error.new("Couldn't genereate screenshot of #{link.url}")
    end
  end

end
