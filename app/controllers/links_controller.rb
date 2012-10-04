class LinksController < KawaController
  prohibit :destroy

  def show
    authorize_action_for(@link)
    @link = LinkPresenter.new(@link)
  end

  protected
  def all
    Link.order_by(created_at: -1).page params[:page]
  end
end
