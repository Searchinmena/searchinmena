@Sim.controller 'ServicesShowCtrl', ['$scope', '$stateParams', 'BusinessItemLoader', 'ServiceFactory',
                                     'SimilarItemsLoader', 'PrevItemLoader', 'NextItemLoader',
                                     'SERVICE_SHOW_PATH', 'MetaService',
  ($scope, $stateParams, BusinessItemLoader, ServiceFactory, SimilarItemsLoader, PrevItemLoader, NextItemLoader,
   SERVICE_SHOW_PATH, MetaService) ->
    BusinessItemLoader.initialize(
      ServiceFactory, $stateParams.id, $scope)
    SimilarItemsLoader.initialize(
      ServiceFactory, $stateParams.id, $scope, SERVICE_SHOW_PATH)

    PrevItemLoader.initialize(
        ServiceFactory, $stateParams.id, $scope)
    NextItemLoader.initialize(
        ServiceFactory, $stateParams.id, $scope)

    # Set meta tags
    ServiceFactory.get({ id: $stateParams.id },
      (attributes) ->
        businessItem = ServiceFactory.buildPresenter(attributes)
        businessItemName = businessItem.attributes.name
        businessItemCountry = businessItem.attributes.business.country
        businessItemCategories = MetaService.getCategories(businessItem.attributes.breadcrumbs)

        businessItemtitle = businessItemName + ' in ' + businessItemCountry + ' | ' + businessItemCategories

        MetaService.set businessItemtitle, businessItem.attributes.description,
          businessItemtitle
    )
]
