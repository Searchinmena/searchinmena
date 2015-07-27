class SIM.BusinessItem
  constructor: (attributes) ->
    @attributes = attributes
    @breadcrumbs = new SIM.Breadcrumbs()
    for categoryAttributes in attributes.breadcrumbs
      @breadcrumbs.push(new SIM.Category(categoryAttributes))

  get: (attribute) ->
    @attributes[attribute]

  breadcrumbsWithoutLast: ->
    @breadcrumbs.withoutLast()

  lastBreadcrumb: ->
    @breadcrumbs.current()

  firstPhoto: ->
    @get('photos')[0].url

  hasPaymentTerms: ->
    @get('payment_terms').length > 0

  hasAttributes: ->
    @get('attributes').length > 0
