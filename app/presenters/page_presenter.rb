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
    h.content_tag(:header) do
      h.content_tag(:h1, @model.title)
    end
  end

  def data
    if @model.embedded_header.empty?
      @model.formatted_data
    else
      result = @model.formatted_data.each_line.to_a[1..-1]
      result.delete_at(0) if result[0] == "\n"
      result.join
    end
  end

end
