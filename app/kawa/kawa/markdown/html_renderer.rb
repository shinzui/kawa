module Kawa
  module Markdown
    class HtmlRenderer < Redcarpet::Render::HTML
      include Redcarpet::Render::SmartyPants
      include Rails.application.routes.url_helpers

      def link(link, title, content)
        kawa_link = find_or_generate_link(link)

        "<a href='#{link_path(kawa_link)}' title='#{kawa_link.url}' class='#{css_classes(link)}'>#{content}</a>"
      end

      def autolink(link, link_type)
        link(link, nil, link) if link_type == :url
      end

      private

      def css_classes(link)
        css_classes = []
        css_classes << "external" if link =~ /^http/i
        css_classes << "github" if link =~ /github/i 
        css_classes.join(" ") 
      end

      def find_or_generate_link(link)
        kawa_link = Link.with_url(link).first
        kawa_link ||= Link.create(:url  => link) 
      end
    end
  end
end