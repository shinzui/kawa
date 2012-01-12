class PagesController < ApplicationController
  before_filter :load_page, :page_crumb, :only  => [:show, :edit, :update]

  rescue_from Tire::Search::SearchRequestFailed do |error|
    if error.message =~ /SearchParseException/ && params[:query]
      flash[:error] = "Sorry, your query '#{params[:query]}' is invalid"
    else
      flash[:error] = "An error occured while searching"
    end
    redirect_to root_path
  end

  def index
    add_crumb "Pages"

    if params[:query]
      @pages = Page.elastic_search(params[:query])
      render 'search_result'
    elsif params[:tag]
      @pages = Page.where(tags_array: params[:tag])
    else
      @pages = Page.all
    end
  end

  def new
    add_crumb "New Page"
    @page = Page.new(params[:page])
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
    redirect_to new_page_path(page: {name: params[:id]}) unless @page
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
      add_crumb @page.name if @page
    end

end
