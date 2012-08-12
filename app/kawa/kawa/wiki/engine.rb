module Kawa::Wiki

  class Engine
    include Singleton

    def add_page(author, page)
      page.author = author
      page.save
    end

    def add_link(creator, link)
      
    end

  end
end
