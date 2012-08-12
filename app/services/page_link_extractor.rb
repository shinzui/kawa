class PageLinkExtractor
  attr_reader :page

  def initialize(page)
    @page = page
  end

  def extract_links
    doc = Nokogiri::HTML.parse(page.formatted_data)
    path = Rails.application.routes.url_helpers.short_url_path("id").gsub("id","")
    link_ids = doc.css('a').map { |a| a['href'] }.map { |l| l[%r|#{path}(.*)|, 1] }
    Link.find(link_ids.compact)
  end

end
