@Sim.service 'BusinessItemUpdater', ['BusinessItemSaver', '$stateParams',
  (BusinessItemSaver, $stateParams) ->
    initialize: (scope, selectsLoader, businessItemFactory, categoriesController) ->
      businessItemFactory.get(id: $stateParams.id,
        (params) ->
          scope.businessItem = businessItemFactory.build(params)
          scope.businessItem.payment_terms = params.payment_terms.ids
          scope.breadcrumbs = SIM.Breadcrumbs.fromParams(params.breadcrumbs)

          scope.attributes = for attributeParams in params.attributes
            new SIM.Attribute.fromParams(attributeParams)
          unless scope.attributes.length > 0
            scope.attributes = (new SIM.Attribute() for i in [0..1])
      )

      BusinessItemSaver.initialize(
        scope, selectsLoader, businessItemFactory.resourceName(),
        categoriesController)
]
