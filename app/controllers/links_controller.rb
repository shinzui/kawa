class LinksController < ApplicationController
  def show
    link = Link.find(params[:id])
    link.record_visit(request.referrer, request.ip)
    redirect_to link.url
  end
end
