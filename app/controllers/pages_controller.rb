class PagesController < ApplicationController
  before_filter :authenticate_user!, :except  => [:index, :show]
  before_filter :load_page, :page_crumb, :only  => [:show, :edit, :update]

  respond_to :json, :html

  rescue_from Tire::Search::SearchRequestFailed do |error|
    if error.message =~ /SearchParseException/ && params[:query]
      flash[:error] = "Sorry, your query '#{params[:query]}' is invalid"
    else
      flash[:error] = "An error occured while searching"
    end
    redirect_to pages_path
  end

  def index
    add_crumb "Pages"

    if params[:query]
      @search = SearchPresenter.new(params[:query])
      render 'search_result'
    elsif TagSearchPresenter.tag_search?(params)
      @search = TagSearchPresenter.new(Page, params)
      add_crumb @search.search_tags
      @pages = @search.result
    else
      @pages = Page.all.desc(:updated_at)
    end
  end

  def new
    add_crumb "New Page"
    page = Page.new(params[:page])
    @page = PageForm.new(page)
  end

  def create
    @page = PageForm.new
    @page.attributes = params[:page]

    if wiki.add_page(current_user, @page)
      redirect_to @page, :notice  => "Success"
    else
      render :action  => :new
    end
  end

  def show
    return redirect_to new_page_path(page: {name: params[:id]}) unless @page
    authorize_action_for(@page)
    respond_with(@page) do |format|
      format.json { render :json  => @page }
      format.html { @page = PagePresenter.new(@page) }
    end
  end

  def edit
    authorize_action_for(@page)
  end

  def update
    authorize_action_for(@page)
    @page = PageForm.new(@page)
    @page.attributes = params[:page]
    if @page.save
      redirect_to @page, :notice  => "Page updated successfully"
    else
      render :edit
    end
  end

  def destroy
    @page = Page.find(params[:id])
    authorize_action_for(@page)
    @page.destroy
    redirect_to pages_path
  end

  private 

    def load_page
      @page = Page.find(params[:id])
    rescue Mongoid::Errors::DocumentNotFound
      @page = nil
    end

    def page_crumb
      add_crumb @page.name if @page
    end

end
