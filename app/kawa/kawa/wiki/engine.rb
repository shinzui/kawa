module Kawa::Wiki

  class Engine
    include Singleton

    def add_page(author, page)
      page.author = author
      page.save
    end

    def add_link(creator, link)
      link.creator = creator 
      link.save
    end
    alias_method :add_bookmark, :add_link

    def add_quote(contributor, quote)
      quote.contributor = contributor
      quote.save
    end

  end
end
