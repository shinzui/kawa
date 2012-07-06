# encoding: utf-8
#
class ScreenshotGrabber
  include Sidekiq::Worker

  Error = Class.new(StandardError)

  def perform(link_id)
    link = Link.find link_id
    generate_screenshot(link)
  end

  def html_link?(link)
    uri = URI.parse(link.url)
    uri.open { |f| !(f.content_type =~ /html/i).nil? }
  end

  def generate_screenshot(link, force = false)
    return unless generate_screenshot?(link, force)

    script_location = File.join(Rails.root, 'lib/screenshot_grabber.coffee')
    output = "#{Dir.tmpdir}/#{Digest::MD5.hexdigest(link.url)}.png"
    phantomjs_opts = "--ignore-ssl-errors=yes"
    `phantomjs #{phantomjs_opts} #{script_location} "#{link.url}" #{output}`
    if FileTest.exists?(output)
      link.url_screenshot = File.open(output)
      link.save
    else
      raise Error.new("Couldn't genereate screenshot of #{link.url}")
    end
  end

  def generate_screenshot?(link, force)
    html_link?(link) && (force || link.generate_screenshot?)
  end

end
