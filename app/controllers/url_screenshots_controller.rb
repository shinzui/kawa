class UrlScreenshotsController < ApplicationController
  before_filter :authenticate_user!

  respond_to :js

  def create
    link = Link.find(params[:link_id])
    if link
      ScreenshotGrabber.perform_async(link.id, true)
    end

    render :nothing  => true
  end

end
