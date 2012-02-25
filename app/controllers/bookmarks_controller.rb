class BookmarksController < KawaController

  def show
    @link = LinkPresenter.new @link
  end

  protected

  def custom_view_path
    "links"
  end

  def model_singular_ivar 
    :@link
  end

  def model_plural_ivar
    :@links
  end

end
