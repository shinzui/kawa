class LinkPresenter
  include BasePresenter

  delegate :id, :url, :title, :description, :pages, :to  => :@model
  attr_reader :model

  def initialize(model)
    @model = model
    self
  end

  def owner
    UserPresenter.new(model.creator).display_name
  end

  def can_delete?
    model.can_destroy?
  end

  def url_screenshot_thumbnail_url
    if model.url_screenshot
      model.url_screenshot.thumb.url
    end
  end

  def url_screenshot_thumbnail
    image = url_screenshot_thumbnail_url || "processing.jpg"
    h.link_to h.short_url_path(model)  do
      h.image_tag image, class: "img-thumbnail"
    end
  end

  def link
    _url = h.short_url_path(model) 
    if title.present?
      h.link_to(title, _url) + h.content_tag(:div, :class  => "url") do
        h.concat(h.content_tag(:span, url))
      end
    else
     h.link_to(url, _url)
    end
  end
  
end
