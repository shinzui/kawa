class Api::PagesController < ApplicationController

  def index
    @pages = Page.all.desc(:updated_at)
    render json: @pages, each_serializer: PageInfoSerializer, root: "pages"
  end

  def show
    page = Page.find(params[:id])
    render json: page, serializer: FullPageSerializer, root: "page"
  end
end
