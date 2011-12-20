class PagesController < ApplicationController

  def new
    @page = Page.new
  end

  def create
    @page = Page.new(params[:page])

    if @page.save
      redirect_to @page, :notice  => "Success"
    else
      render :action  => :new
    end
  end

  def show
    # page = Page.find(params[:id])
    page = Page.find_by_slug(params[:id])
    @page = PagePresenter.new(page)
  end

end
