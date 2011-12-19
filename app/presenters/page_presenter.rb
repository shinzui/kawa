class PagePresenter
  delegate :name, :to  => :@page

  def initialize(page)
    @page = page
  end

  def data
    MarkupRenderer.renderer(@page.markup)[@page.raw_data]
  end

end
