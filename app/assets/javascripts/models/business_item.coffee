class SIM.BusinessItem
  constructor: (attributes) ->
    @attributes = attributes
    @payment_terms = {}
    @breadcrumbs = new SIM.Breadcrumbs()
    for categoryAttributes in attributes.breadcrumbs
      @breadcrumbs.push(new SIM.Category(categoryAttributes))

  get: (attribute) ->
    @attributes[attribute]

  breadcrumbsWithoutLast: ->
    @breadcrumbs.withoutLast()

  lastBreadcrumb: ->
    @breadcrumbs.current()
