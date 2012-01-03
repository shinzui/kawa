class PageRenderer
  include Rails.application.routes.url_helpers

  def initialize(page = page)
    @page = page
    @tagmap = {}
  end

  def render
    data = @page.raw_data
    data = preprocess_tags(data)
    data = MarkupRenderer.renderer(@page.markup)[data]
    post_process_tags(data)
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
      
      page = Page.where(:name  => page_name).first
      page ||= Page.new(:name  => page_name)
      if page.new_record?
        presence = 'absent'  
        path = new_page_path(page: {name: page_name})
      else
        presence = 'present'
        path = page_path(page)
      end
      "<a class=\"#{presence}\" href=\"#{path}\">#{title}</a>"
    end
end
