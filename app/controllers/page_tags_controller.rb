class PageTagsController < ApplicationController

  def index
    @tags = PageTagsPresenter.new
  end
end
