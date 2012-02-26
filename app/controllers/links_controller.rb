class LinksController < KawaController
  prohibit :destroy

  def show
    @link = LinkPresenter.new(@link)
  end

  protected
  def all
    Link.all.order_by(:updated_at, :desc)
  end
end
