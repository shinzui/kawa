module Kawa::Wiki::Plugin
  class WikiStat < WikiPlugin
    include Rails.application.routes.url_helpers
    include RenderingPlugin

    def process(options = {})
      Mustache.render(inline_template, stats)
    end

    def inline_template
      data = IO.read(__FILE__).gsub("\r\n", "\n").split(/^__END__$/, 2)[1]
    end

    def stats
      { page_count: Page.count,
        page_tags_count: Page.tags.count,
        pages_path: pages_path,
        page_tags_path: page_tags_path,
        quotes_path: quotes_path,
        quote_count: ::Quote.count,
        quote_tags_count: ::Quote.tags.count,
        bookmarks_path: bookmarks_path,
        bookmark_count: ::Bookmark.count,
        bookmark_tags_count: ::Bookmark.tags.count
      }
    end
  end
end

__END__
<aside class="wiki_stat">
  <p> Wiki has <a href="{{pages_path}}">{{page_count}} pages</a> tagged with 
     <a href="{{page_tags_path}}">{{page_tags_count}} tags</a>.</p>
  <p> Wiki has <a href="{{quotes_path}}">{{quote_count}} quotes</a> tagged with {{quote_tags_count}} tags.</p>
  <p> Wiki has <a href="{{bookmarks_path}}">{{bookmark_count}} bookmarks</a> tagged with {{bookmark_tags_count}} tags.</p>
</aside>
