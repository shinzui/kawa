module Kawa::Wiki

  class Engine
    include Singleton

    def add_page(author, page)
      page.author = author
      page.save
    end

  end
end
