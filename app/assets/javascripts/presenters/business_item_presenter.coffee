class SIM.BusinessItemPresenter
  BASIC_INFO = [
    'model_number', 'brand_name', 'min_order_quantity_number',
    'place_of_origin', 'scope_of_work', 'average_completion_time',
    'fob_price', 'port', 'supply_ability_capacity', 'payment_terms', 'packaging_details']

  SNAPSHOT_SIZE = 5

  constructor: (attributes) ->
    @attributes = attributes
    @business = new SIM.BusinessPresenter(attributes.business)
    @breadcrumbs = new SIM.Breadcrumbs()
    for categoryAttributes in attributes.breadcrumbs
      @breadcrumbs.push(new SIM.Category(categoryAttributes))
    @propertyPresenterFactory = new SIM.PropertyPresenterFactory

  get: (attribute) ->
    @attributes[attribute]

  breadcrumbsWithoutLast: ->
    @breadcrumbs.withoutLast()

  lastBreadcrumb: ->
    @breadcrumbs.current()

  coverPhotoUrl: (type) ->
    @get('cover_photo')[type || 'url']

  hasPaymentTerms: ->
    @get('payment_terms').length > 0

  hasAttributes: ->
    @get('attributes').length > 0

  existingBasicInfo: ->
    _(BASIC_INFO).select((property) =>
      # check if present
      # underscore's isEmpty is returning true for numbers...
      presenter = @propertyPresenterFactory.build(property, @)
      presenter.isPresent()
    )

  hasAnyBasicInfoPresent: ->
    @existingBasicInfo().length > 0

  basicInfoSnapshot: ->
    @existingBasicInfo().slice(0, SNAPSHOT_SIZE)

  translationKeyFor: (property) ->
    "business_item.#{property}"

  displayProperty: (property) ->
    presenter = @propertyPresenterFactory.build(property, @)
    presenter.display()

  businessId: ->
    @business.id()

  businessName: ->
    @business.name()

  businessLocation: ->
    @business.location()

  businessPath: ->
    @business.path()

@Sim.value('BusinessItemPresenter', SIM.BusinessItemPresenter)

