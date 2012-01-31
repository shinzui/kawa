# encoding: UTF-8
class PagePresenter
  include Kawa::Common::Presenter
  include BasePresenter

  delegate :name, :to  => :@model
  attr_reader :model

  def initialize(page)
    @model = page
  end

  def title
    "川 - #{@model.title}"
  end

  def header
    h.content_tag(:h1, @model.title) if @model.title == @model.name
  end

  def data
    @model.formatted_data
  end

end
