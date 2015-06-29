class SIM.Breadcrumbs
  constructor: (defaultTitle) ->
    @items = []
    @defaultTitle = defaultTitle
    @title = @defaultTitle

  push: (item) ->
    currentItem = @current()
    if currentItem && currentItem.level == item.level
      return

    @title = null
    @items.push(item)

  pop: ->
    @items.pop()

    if @items.length <= 0
      @title = @defaultTitle

  current: ->
    @items[@items.length - 1]

  withoutLast: ->
    @items.slice(0, -1)
