class LinkPresenter
  include BasePresenter

  delegate :id, :url, :title, :description, :to  => :@model

  def initialize(model)
    @model = model
  end

  def link
    if title
      h.link_to(title, url) + h.content_tag(:span, url)
    else
     h.link_to(url, url)
    end
  end
  
end
