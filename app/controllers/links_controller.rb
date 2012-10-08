class LinksController < KawaController
  prohibit :destroy

  respond_to :json, :html

  def show
    authorize_action_for(@link)
    respond_with(@link) do |format|
      format.json { render :json  => @link, :serializer  => LinkSerializer }
      format.html { @link = LinkPresenter.new(@link) }
    end
  end

  protected
  def all
    Link.order_by(created_at: -1).page params[:page]
  end
end
