class PagesController < ApplicationController

  before_filter :load_page, :page_crumb, :only  => [:show, :edit, :update]

  def index
    add_crumb "Pages"
    @pages = Page.all
  end

  def new
    add_crumb "New Page"
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
    @page = PagePresenter.new(@page)
  end

  def edit
  end

  def update
    if @page.update_attributes(params[:page])
      redirect_to @page, :notice  => "Page updated successfully"
    else
      render :edit
    end
  end

  def destroy
    @page = Page.find_by_slug(params[:id])
    @page.destroy
    redirect_to pages_path
  end

  private 

    def load_page
      @page = Page.find_by_slug(params[:id])
    end

    def page_crumb
      add_crumb @page.name
    end

end
