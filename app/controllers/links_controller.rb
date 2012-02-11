class LinksController < ApplicationController
  before_filter :load_link, :only  => [:show, :edit, :update]

  def new
    @link = Link.new
  end

  def create
    @link = Link.new(params[:link])

    if @link.save
      redirect_to @link, notice: "Link added successfully"
    else
      render :new
    end
  end

  def show
    @link = LinkPresenter.new(@link)
  end

  private
  def load_link
    @link = Link.find params[:id]
  end
end
