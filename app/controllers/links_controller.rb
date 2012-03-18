class LinksController < KawaController
  prohibit :destroy

  def show
    @link = LinkPresenter.new(@link)
  end

  protected
  def all
    Link.all.order_by(:created_at, :desc)
  end
end
