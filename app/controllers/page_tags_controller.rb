class PageTagsController < ApplicationController
  respond_to :json, :html

  def index
    @tags = PageTagsPresenter.new(params[:term])

    respond_with(@tags)
  end
end
