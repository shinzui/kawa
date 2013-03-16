window.Kawa ?= {}

class Kawa.KeyboardShortcutManager
  constructor: ->
    @setupScope()
    @setupGlobalShortcuts()
    @setupPageShortcuts()
    @setupBookmarkShortcuts()
    @setupNavigationShortcuts()
    @setupQuoteShortcuts()

  setupGlobalShortcuts: ->
    key '/', -> $('input.search-query').focus()
    key 'ctrl+c', -> history.back()

  setupScope: ->
    key 'n', -> key.setScope('new')
    key 'g', -> key.setScope('go')
    key 'v', -> key.setScope('view')

  setupPageShortcuts: ->
    key 'e',   -> $('a[rel=edit-page]:first').each -> window.location = $(this).attr('href')
    key 'p', 'new', ->
      new_page_link = $('a[rel=new-page]:first')
      if new_page_link.length
        window.location = $(new_page_link).attr('href')
      else
        window.location = Routes.new_page_path()

  setupBookmarkShortcuts: ->
    key 'b', 'new', -> window.location = Routes.new_bookmark_path()

  setupNavigationShortcuts: ->
    key 'q', 'go', -> window.location = Routes.quotes_path()
    key 'h', 'go', -> window.location = "/"
    key 'l', 'go', -> window.location = Routes.links_path()
    key 'b', 'go', -> window.location = Routes.bookmarks_path()
    key 'p', 'go', -> window.location = Routes.pages_path()

  setupQuoteShortcuts: ->
    key 'q', 'new', -> window.location = Routes.new_quote_path()

class Kawa.LinkManager
  template: JST["link_menu"]
  tooltipOptions: delay: { show: 500, hide: 50 }

  constructor: ->
    @setupKeyboardShortcut()
    @setupTooltips()

  setupTooltips: ->
    $('a.external').tooltip(@tooltipOptions)

  setupKeyboardShortcut: ->
    key 'm', =>
      @showMenu()
    key 's', 'view', =>
      @viewScreenshot()

  showMenu: ->
    if @currentLink
      $link = $(@currentLink)
      $link.tooltip("destroy")
      $menu = $(@template({"link": {"id":"#{$link.data('id')}"}}))
      $link.append($menu)
      $menu.data('e', @event)
      .css('position','fixed')
      .css('left',@event.clientX)
      .css('top',@event.clientY)
      .css('display','block')

  clearMenus: ->
    $('.link-menu')
      .css('display','none')
      .data('e',undefined)

  resetTooltip: ->
    $link = $(@currentLink)
    $link.tooltip(@tooltipOptions)

  viewScreenshot: ->
    if @currentLink
      $link = $(@currentLink)
      $link.wrap("<div class='popover-wrapper'/>")
      $.ajax(url: Routes.link_path({"id": $link.data("id")}), success: (data)->
        imageThumbUrl = data.link.url_screenshot_thumb
        $link.tooltip("hide")
        thumbLink = "<a href='#{$link.attr('href')}' class='thumbnail' data-no-turbolink><img src='#{imageThumbUrl}'/></a>"
        popoverContent = if imageThumbUrl then thumbLink else "Processing link screenshot"
        $link.popover({"content": popoverContent, "placement": "right"})
        $link.popover('show'))

  clearPopovers: ->
    $('.popover-wrapper a').popover('hide')

  getCurrentLink: ->
    @currentLink

  setCurrentLink: (event)->
    if event
      @currentLink = event.target
      @event = event
    else if @currentLink
      @event = null
      @resetTooltip()
      @currentLink = null



initKawa = ->
  $ = jQuery
  $('.quote, .link').on 'mouseenter mouseleave', (event) =>
    $(event.currentTarget).toggleClass('hover')
  linkManager = new Kawa.LinkManager()
  $('body').on('click.link-menu.data-api', linkManager.clearMenus)
  $('body').on('click.popover.data-api', linkManager.clearPopovers)
  $('a.external').hover ((e) -> linkManager.setCurrentLink(e)),((e) -> linkManager.setCurrentLink(null))
  $('pre code').each( (i,e) -> hljs.highlightBlock(e))
  shortcutManager = new Kawa.KeyboardShortcutManager()

jQuery -> initKawa()
$(document).on 'page:load', initKawa

