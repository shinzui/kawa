module Kawa
  module Wiki
    module Plugin
      class WikiStat < WikiPlugin
        include Rails.application.routes.url_helpers
        include RenderingPlugin

        def process(options = {})
          Mustache.render(inline_template(__FILE__), stats)
        end

        def stats
          { page_count: ::Page.count,
            page_tags_count: ::Page.tags.count,
            pages_path: pages_path,
            page_tags_path: page_tags_path,
            quotes_path: quotes_path,
            quote_count: ::Quote.count,
            quote_tags_count: ::Quote.tags.count,
            bookmarks_path: bookmarks_path,
            bookmark_count: ::Bookmark.count,
            link_count: ::Link.count,
            links_path: links_path,
            link_tags_count: ::Link.tags.count
          }
        end
      end
    end
  end
end

__END__
<aside class="wiki_stat">
  <p> Wiki has <a href="{{pages_path}}">{{page_count}} pages</a> tagged with 
     <a href="{{page_tags_path}}">{{page_tags_count}} tags</a>.</p>
  <p> Wiki has <a href="{{quotes_path}}">{{quote_count}} quotes</a> tagged with {{quote_tags_count}} tags.</p>
  <p> Wiki has <a href="{{links_path}}">{{link_count}} links</a>, with <a href="{{bookmarks_path}}">{{bookmark_count}} bookmarks</a>, tagged with {{link_tags_count}} tags.</p>
</aside>
