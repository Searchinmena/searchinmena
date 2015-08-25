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
      )

      BusinessItemSaver.initialize(
        scope, selectsLoader, businessItemFactory.resourceName(),
        categoriesController)
]
