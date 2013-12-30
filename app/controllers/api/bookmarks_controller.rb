class Api::BookmarksController < ApplicationController

  def index
    @bookmarks = Bookmark.all.order_by(created_at: -1)
    render json: @bookmarks, root: "bookmarks"
  end

  def show
    @bookmark = Bookmark.find params[:id]
    render json: @bookmark, root: "bookmark"
  end
end
