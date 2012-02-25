class LinksController < KawaController
  prohibit :destroy

  def show
    @link = LinkPresenter.new(@link)
  end
end
