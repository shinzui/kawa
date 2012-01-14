class PageRenderer
  include Rails.application.routes.url_helpers

  class << self
    include Rails.application.routes.url_helpers
  end

  def initialize(page = page)
    @page = page
    @tagmap = {}
    @plugin_processor = Kawa::Wiki::Plugin::Processor.new(@page)
  end

  def render
    data = @page.raw_data
    data = preprocess_tags(data)
    data = @plugin_processor.preprocess_plugins(data)
    data = MarkupRenderer.renderer(@page.markup)[data]
    data = post_process_tags(data)
    @plugin_processor.post_process_rendering_plugins(data)
  end

  def self.linked_page_path(page)
    if page.new_record?
      new_page_path(page: {name: page.name})
    else
      page_path(page)
    end
  end

  def linked_page_path(page)
   self.class.linked_page_path(page) 
  end

  private
    def preprocess_tags(data)
      data.gsub!(/(.?)\[\[(.+?)\]\]/m) do
        if $1 == "'"
          "[[#{$2}]]"
        else
          stamp = Digest::SHA1.hexdigest($2)
          @tagmap[stamp] = $2
          "#{$1}#{stamp}"
        end
      end
      data
    end

    def post_process_tags(data)
      @tagmap.each do |stamp, tag|
        data.gsub!(stamp, process_tag(tag))
      end
      data
    end

    def process_tag(tag)
      parts = tag.split('|')
      title, page_name = *parts.compact.map(&:strip)
      page_name ||= title
      
      page = Page.named(page_name).first
      page ||= Page.new(:name  => page_name)
      presence = page.new_record? ? 'absent' : 'present'
      "<a class=\"#{presence}\" href=\"#{linked_page_path(page)}\">#{title}</a>"
    end
end
