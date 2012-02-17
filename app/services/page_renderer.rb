class PageRenderer
  include Rails.application.routes.url_helpers

  class << self
    include Rails.application.routes.url_helpers
  end

  def initialize(page)
    @page = page
    @tagmap = {}
    @codemap = {}
    @plugin_processor = Kawa::Wiki::Plugin::Processor.new(@page)
  end

  def render
    data = @page.raw_data.clone
    data = extract_code(data)
    data = preprocess_tags(data)
    data = @plugin_processor.preprocess_plugins(data)
    data = MarkupRenderer.renderer(@page.markup)[data]
    data = post_process_tags(data)
    data = highlight_code(data)
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
    def extract_code(data)
      data.gsub!(/^``` ?([^\r\n]+)?\r?\n(.+?)\r?\n```\r?$/m) do
        stamp = Digest::SHA1.hexdigest("#{$1}.#{$2}")
        @codemap[stamp] = {:lang  => $1, :code  => $2}
        stamp
      end
      data
    end

    def highlight_code(data)
      @codemap.each do |stamp, spec|
        code = spec[:code]
        code.gsub!(/^(  |\t)/m, '') if code.lines.all? {|l| l  =~ /(  |\t)/ }
        highlight = Pygments.highlight(code, :lexer  => spec[:lang])
        data.gsub!(stamp, highlight)
      end
      data 
    end

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
