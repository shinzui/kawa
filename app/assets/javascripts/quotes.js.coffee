jQuery ->
  $ = jQuery
  $('.quote').on 'hover', (event) =>
    $(event.currentTarget).toggleClass('hover')

