class PagePresenter
  delegate :name, :to  => :@model
  attr_reader :model

  def initialize(page)
    @model = page
  end

  def data
    PageRenderer.new(@model).render
  end

end
