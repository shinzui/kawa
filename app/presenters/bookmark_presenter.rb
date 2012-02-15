class BookmarkPresenter
  include BasePresenter

  delegate :id, :url, :title, :description, :to  => :@model
  attr_reader :model

  def initialize(model)
    @model = model
    self
  end

  def link
    if title
      h.link_to(title, url) + h.content_tag(:div, :class  => "url") do
        h.concat(h.content_tag(:span, url))
      end
    else
     h.link_to(url, url)
    end
  end
  
end