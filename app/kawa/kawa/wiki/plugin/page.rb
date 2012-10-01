module Kawa
  module Wiki
    module Plugin
      class Page < WikiPlugin
        include Rails.application.routes.url_helpers
        include RenderingPlugin

        def process(options)
          @tags = options.delete(:tags)
          raise MissingArgument.new("#{name} #{options} plugin require the tags option") unless @tags
          @tags = @tags.split(",")
          Mustache.render(inline_template(__FILE__), {pages: pages})
        end

        def pages
          pages = ::Page.tagged(@tags)
          pages.reject {|p| p == page}.map do |page|
            {name: page.name, url: page_path(page)}
          end
        end

      end
    end
  end
end

__END__
<ul class="page-plugin">
 {{#pages}}
   <li><a href="{{url}}">{{name}}</a></li>
 {{/pages}}
</ul>
