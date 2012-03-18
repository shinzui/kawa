namespace :links do
  desc "Generate screenshot of all links"
  task :generate_screenshots  =>  :environment do
    screenshot_grabber = ScreenshotGrabber.new
    Link.all.order_by(:created_at, :asc) .each do |link|
      puts "processing #{link.url}"
      begin
        screenshot_grabber.generate_screenshot link
      rescue OpenURI::HTTPError  => e
        puts e.inspect
      rescue ScreenshotGrabber::Error  => e
        puts e
      rescue  => e
        puts e.inspect
      end
    end
  end

end
