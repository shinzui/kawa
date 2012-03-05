jQuery ->
  $ = jQuery
  $('.quote, .link').on 'hover', (event) =>
    $(event.currentTarget).toggleClass('hover')
  $('.page-data table').addClass("table table-striped table-bordered table-condensed")
  key '/',   -> $('input.search-query').focus()
  key 'e',   -> $('a[rel=edit-page]:first').each -> window.location = $(this).attr('href')
  key 'n+q', -> window.location = Routes.new_quote_path()
  key 'n+b', -> window.location = Routes.new_bookmark_path()
  key 'n+p', -> 
    new_page_link = $('a[rel=new-page]:first')
    if new_page_link.length
      window.location = $(new_page_link).attr('href')
    else
      window.location = Routes.new_page_path()
  key 'g+h', -> window.location = "/"
  key 'g+l', -> window.location = Routes.links_path()
  key 'g+b', -> window.location = Routes.bookmarks_path()
  key 'g+p', -> window.location = Routes.pages_path()
  key 'g+q', -> window.location = Routes.quotes_path()
  key 'ctrl+c', -> history.back()
