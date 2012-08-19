class SidebarPresenter
  include Kawa::Common::Presenter

  def recently_changed(page_scope = Page.all, limit = 5)
    h.content_tag(:ul) do
      page_scope.desc(:updated_at).limit(limit).each do |page|
        h.concat(h.content_tag(:li) do
          h.link_to page.name, h.page_path(page)
        end) if h.current_or_guest_user.can_read?(page)
      end
    end
  end

  def recently_changed_pages
    h.content_tag(:h5, "Recently modified:") +
    recently_changed
  end

  def current_user_private_pages
    return unless h.current_user
    private_pages_scope = Page.private.authored(h.current_user)
    if private_pages_scope.count > 0
      h.content_tag(:h5, "Recently modified private pages:") +
      recently_changed(private_pages_scope)
    end
  end
end
