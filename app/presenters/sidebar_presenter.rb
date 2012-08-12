class SidebarPresenter
  include Kawa::Common::Presenter

  def recently_changed(limit = 5)
    h.content_tag(:ul) do
      Page.all.desc(:updated_at).limit(limit).each do |page|
        h.concat(h.content_tag(:li) do
          h.link_to page.name, h.page_path(page)
        end) if h.current_or_guest_user.can_read?(page)
      end
    end
  end
end
