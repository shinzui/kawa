class LinkObserver < Mongoid::Observer
  def before_save(link)
    if !link.new_record? && link.data_changed?
      ScreenshotGrabber.perform_async(link.id) unless link.data_was == link.url
    end
  end

  def before_create(link)
    ScreenshotGrabber.perform_async(link.id)
  end
end
