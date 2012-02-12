jQuery ->
  $ = jQuery
  $('.quote, .bookmark').on 'hover', (event) =>
    $(event.currentTarget).toggleClass('hover')
