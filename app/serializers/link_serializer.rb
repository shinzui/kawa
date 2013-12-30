class LinkSerializer < ActiveModel::Serializer
  attributes :id, :url_screenshot_url, :url_screenshot_thumb_url, :url, :tags

  def id
    object.id
  end

  def url_screenshot_url
    object.url_screenshot.url
  end

  def url_screenshot_thumb_url
    object.url_screenshot.thumb.try(:url)
  end
end
