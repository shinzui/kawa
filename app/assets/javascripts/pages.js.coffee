jQuery ->
  $ = jQuery
  $("#tags").ajaxChosen {
    method: 'GET',
    url: '/page_tags.json',
    dataType: 'json'
  }, (data)  => 
    tags = {}
    _.each data, (tag, idx) -> tags[tag['name']] = tag['name']
    tags
