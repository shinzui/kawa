class LinkPresenter
  include BasePresenter

  delegate :id, :url, :title, :description, :pages, :to  => :@model
  attr_reader :model

  def initialize(model)
    @model = model
    self
  end

  def can_delete?
    model.class != Link
  end

  def link
    if title.present?
      h.link_to(title, url) + h.content_tag(:div, :class  => "url") do
        h.concat(h.content_tag(:span, url))
      end
    else
     h.link_to(url, url)
    end
  end
  
end
