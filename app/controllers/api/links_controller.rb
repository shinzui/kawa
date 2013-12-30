class Api::LinksController < ApplicationController
  def index
    @links = Link.all.order_by(created_at: -1)
    render json: @links, root: "links"
  end

  def show
    @link = Link.find params[:id]
    render json: @link, root: "link"
  end

end
