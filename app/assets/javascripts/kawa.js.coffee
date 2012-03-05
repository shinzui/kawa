jQuery ->
  $ = jQuery
  $('.quote, .link').on 'hover', (event) =>
    $(event.currentTarget).toggleClass('hover')
  $('.page-data table').addClass("table table-striped table-bordered table-condensed")
  key '/',   -> $('input.search-query').focus()
  key 'e',   -> $('a[rel=edit-page]:first').each -> window.location = $(this).attr('href')
  key 'n', -> key.setScope('new')
  key 'g', -> key.setScope('go')

  key 'q', 'new', -> window.location = Routes.new_quote_path()
  key 'b', 'new', -> window.location = Routes.new_bookmark_path()
  key 'p', 'new', -> 
    new_page_link = $('a[rel=new-page]:first')
    if new_page_link.length
      window.location = $(new_page_link).attr('href')
    else
      window.location = Routes.new_page_path()
  key 'h', 'go', -> window.location = "/"
  key 'l', 'go', -> window.location = Routes.links_path()
  key 'b', 'go', -> window.location = Routes.bookmarks_path()
  key 'p', 'go', -> window.location = Routes.pages_path()
  key 'q', 'go', -> window.location = Routes.quotes_path()
  key 'ctrl+c', -> history.back()
