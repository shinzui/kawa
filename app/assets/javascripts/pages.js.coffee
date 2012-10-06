jQuery ->
  $ = jQuery
  $("#tags").select2 {
    placeholder: 'Select tags',
    width: "300px",
    multiple: true,
    initSelection: (element, callback) ->
      data = _.map($(element.val().split(",")), (e) -> {id: e, text: e})
      callback(data)
    ajax: {
      url: '/page_tags.json',
      data: (term, page) ->
        term: term
      results: (data, page) =>
        tags = []
        _.each data, (tag, idx) -> tags.push {id: tag['name'], text: tag['name']}
        { results: tags }
    }
  }
