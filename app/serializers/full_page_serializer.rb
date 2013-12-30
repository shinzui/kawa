class FullPageSerializer < PageInfoSerializer
  attributes :tags, :created_at, :updated_at, :header, :data

  def page_presenter
    @page_presenter ||= PagePresenter.new(object)
  end

  def header
    page_presenter.header
  end

  def data
    page_presenter.data
  end

end
