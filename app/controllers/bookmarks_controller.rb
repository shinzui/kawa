class BookmarksController < KawaController

  def show
    @bookmark = BookmarkPresenter.new(@bookmark)
  end

end
