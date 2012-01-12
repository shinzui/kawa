class PagePresenter
  delegate :name, :to  => :@model
  attr_reader :model

  def initialize(page)
    @model = page
  end

  def tags
    @model.tags_array
  end

  def tags?
    tags.present?  
  end

  def data
    PageRenderer.new(@model).render
  end

end
