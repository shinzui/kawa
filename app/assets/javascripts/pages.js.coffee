configureTagAutocomplete = ->
  $ = jQuery
  $("#tags").select2 {
    placeholder: 'Select tags',
    width: "300px",
    multiple: true,
    minimumInputLength: 2,
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

configureDropzone = ->
  $('.remove-attachment').on 'click', (e) ->
    attachmentId = $(this).data('attachmentId')
    $.ajax
      url: "/attachments/#{attachmentId}"
      dataType: 'json'
      type: 'delete'
    .done =>
      $('#attachment-container').find("[value='#{attachmentId}']").remove()
      $(this).parent().remove()
    .fail (jqXHR, textStatus, errorThrown)->
      console.log ("Failed to delete attachment #{textStatus}")
      
  $("div#attachment-upload").dropzone
    url: "/attachments",
    maxFileSize: 25,
    uploadMultiple: true,
    addRemoveLinks: true,
    parallelUploads: true,
    headers: "X-CSRF-Token" : $('meta[name="csrf-token"]').attr('content')
    thumbnailWidth: 100
    thumbnailHeight: 100
    init: ->
      @.on 'success', (file) ->
        attachment = JSON.parse(file.xhr.response)
        attachmentId = attachment.id
        console.log attachment
        $('#page_raw_data').insertAtCursor("![](#{attachment.m_path})")
        indexes = []
        $('#attachment-container').children().each ->
          indexes.push parseInt($(@).data('attachmentIndex'), 10)

        maxIndex = if indexes.length > 0 then Math.max indexes... else -1
        index = maxIndex + 1
        fieldTemplate = """
          <input id='page_attachment_ids[#{index}]' name='page[attachment_ids[#{index}]]' 
          type='hidden' value='#{attachmentId}' data-attachment-index="#{index}">
        """
        $('#attachment-container').append(fieldTemplate)
      @.on 'removedfile', (file) ->
        attachmentId = JSON.parse(file.xhr.response).id
        $('#attachment-container').find("[value='#{attachmentId}']").remove()
        $.ajax
          url: "/attachments/#{attachmentId}"
          dataType: 'json'
          type: 'delete'

$ ->
  Dropzone.autoDiscover = false
  configureTagAutocomplete()
  configureDropzone()
  

$(document).on 'page:load', configureTagAutocomplete
