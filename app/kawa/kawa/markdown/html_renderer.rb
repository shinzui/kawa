module Kawa
  module Markdown
    class HtmlRenderer < Redcarpet::Render::HTML
      include Redcarpet::Render::SmartyPants
      include Rails.application.routes.url_helpers

      def initialize(options = {})
        @table_css_class = options.delete(:table_css_class)
        super
      end

      def link(link, title, content)
        kawa_link = find_or_generate_link(link)

        "<a href='#{short_url_path(kawa_link)}' title='#{kawa_link.url}' data-id='#{kawa_link.id}' class='#{css_classes(link)}' data-no-turbolink>#{content}</a>"
      end

      def autolink(link, link_type)
        link(link, nil, link) if link_type == :url
      end

      def table(header, body)
        header = "<thead>#{header}</thead>"
        body = "<tbody>#{body}</tbody>"
         "<table #{table_css_class}>#{header}\n#{body}\n</table>"
      end

      private

      def table_css_class
        @table_css_class ? "class='#{@table_css_class}'" : ""
      end

      def css_classes(link)
        css_classes = []
        css_classes << "external" if link =~ /^http/i
        css_classes << "github" if link =~ /github/i 
        css_classes << "quora" if link =~ /quora/i
        css_classes.join(" ") 
      end

      def find_or_generate_link(link)
        kawa_link = Link.with_url(link).first
        kawa_link ||= Link.create(:url  => link) 
      end
    end
  end
end
