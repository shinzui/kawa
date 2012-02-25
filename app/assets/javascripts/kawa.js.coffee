jQuery ->
  $ = jQuery
  $('.quote, .link').on 'hover', (event) =>
    $(event.currentTarget).toggleClass('hover')
  $('.page-data table').addClass("table table-striped table-bordered table-condensed")
