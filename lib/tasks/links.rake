namespace :links do
  desc "Generate screenshot of all links"
  task :generate_screenshots  =>  :environment do
    Link.all.each do |link|
      screenshot_grabber = ScreenshotGrabber.new
      screenshot_grabber.generate_screenshot link
    end
  end

end
