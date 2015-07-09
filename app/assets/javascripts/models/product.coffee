class SIM.Product
  constructor: (attributes) ->
    @id = attributes.id
    @name = attributes.name
    @thumbUrl = attributes.thumb_url
    @breadcrumbs = new SIM.Breadcrumbs()
    for categoryAttributes in attributes.breadcrumbs
      @breadcrumbs.push(new SIM.Category(categoryAttributes))

  breadcrumbsWithoutLast: ->
    @breadcrumbs.withoutLast()

  lastBreadcrumb: ->
    @breadcrumbs.current()
