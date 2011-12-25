class PagePresenter
  delegate :name, :to  => :@model
  attr_reader :model

  def initialize(page)
    @model = page
  end

  def data
    MarkupRenderer.renderer(@model.markup)[@model.raw_data]
  end

end
