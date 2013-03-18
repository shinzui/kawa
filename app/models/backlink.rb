class Backlink
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :inbound_page, class_name: 'Page', inverse_of: :inbound_page_links
  belongs_to :outbound_page, class_name: 'Page', inverse_of: :outbound_page_links

  field :inbound_page_name

  def self.update_outbound_links(page)
    renderer = PageRenderer.new(page)
    linked_page_names = renderer.linked_pages
    remove_outdated_backlinks(page, linked_page_names)
    sync_backlinks(page, linked_page_names)

  end

  def self.sync_backlinks(page, linked_page_names)
    linked_page_names.each do |name|
      linked_page = Page.named(name).first
      if linked_page
        update_page_backlink(linked_page, page)
      else
        backlink = Backlink.where(inbound_page_name: /^#{name}/i, inbound_page_id: page.id).first
        Backlink.create(inbound_page_name: name, outbound_page: page) unless backlink
      end
    end
  end

  def self.update_page_backlink(linked_page, page)
    backlink = Backlink.where(inbound_page_id: page.id, outbound_page_id: linked_page.id).first
    unless backlink
      backlink = Backlink.where(inbound_page_name: /^#{name}/i, inbound_page_id: page.id).first
      if backlink
        backlink.inbound_page_name = nil
        backlink.outbound_page = linked_page
        backlink.save
      else
        Backlink.create(inbound_page: linked_page, outbound_page: page)
      end
    end
  end

  def self.remove_outdated_backlinks(page, linked_page_names)
    ids = Page.in(name: linked_page_names).pluck(:id)
    extra_backlinks = Backlink.where(outbound_page: page, :inbound_page_name.exists  => false).nin(inbound_page_id: ids)
    extra_backlinks.map(&:destroy)

    extra_backlinks = Backlink.where(outbound_page: page).nin(inbound_page_name: linked_page_names)
    extra_backlinks.map(&:destroy)
  end

  def self.update_inbound_links(page)
    if page.destroyed?
      Backlink.where(inbound_page_id: page).update_all(inbound_page_id: nil, inbound_page_name: page.name)
    else
      Backlink.where(inbound_page_name: page.name).update_all(inbound_page_name: nil, inbound_page_id: page.id)
    end
  end

end
