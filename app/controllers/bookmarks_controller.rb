class BookmarksController < KawaController
  respond_to :html

  def show
    authorize_action_for(@link)
    @link = LinkPresenter.new @link
  end

  protected

  def all
    Bookmark.order_by(created_at: -1).page params[:page]
  end

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
