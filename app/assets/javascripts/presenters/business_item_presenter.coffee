class SIM.BusinessItemPresenter
  BASIC_INFO = [
    'model_number', 'brand_name', 'min_order_quantity_number',
    'place_of_origin', 'scope_of_work', 'average_completion_time',
    'fob_price', 'port', 'supply_ability_capacity', 'payment_terms', 'packaging_details']

  SNAPSHOT_SIZE = 5

  constructor: (attributes) ->
    @attributes = attributes
    @business = new SIM.BusinessPresenter(attributes.business)
    @breadcrumbs = SIM.Breadcrumbs.fromParams(attributes.breadcrumbs)
    @propertyPresenterFactory = new SIM.PropertyPresenterFactory

  get: (attribute) ->
    @attributes[attribute]

  breadcrumbsWithoutLast: ->
    @breadcrumbs.withoutLast()

  lastBreadcrumb: ->
    @breadcrumbs.current()

  coverPhotoUrl: (type) ->
    @get('cover_photo')[type || 'url']

  paymentTerms: ->
    @get('payment_terms').names

  hasPaymentTerms: ->
    @paymentTerms().length > 0

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
    @business.showPath()

  templatePath: ->
    'search/_business_item_result.html'

@Sim.value('BusinessItemPresenter', SIM.BusinessItemPresenter)

