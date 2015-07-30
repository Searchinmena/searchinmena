class SIM.BusinessItem
  BASIC_INFO = [
    'model_number', 'brand_name', 'min_order_quantity_number',
    'fob_price', 'supply_ability_capacity', 'payment_terms', 'packaging_details']

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

  hasAnyBasicInfoPresent: ->
    _(BASIC_INFO).any((x) =>
      !_(@get(x)).isEmpty()
    )
