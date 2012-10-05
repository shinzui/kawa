class LinkSerializer < ActiveModel::Serializer
  attributes :id, :url_screenshot, :url_screenshot_thumb

  def url_screenshot
    object.url_screenshot.url
  end

  def url_screenshot_thumb
    object.url_screenshot.thumb.try(:url)
  end
end
