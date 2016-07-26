@Sim.controller 'ProductsShowCtrl', ['$scope', '$stateParams',
  'BusinessItemLoader', 'ProductFactory', 'SimilarItemsLoader', 'PrevItemLoader', 'NextItemLoader'
   'PRODUCT_SHOW_PATH', 'MetaService',
  ($scope, $stateParams, BusinessItemLoader, ProductFactory, SimilarItemsLoader, PrevItemLoader, NextItemLoader, PRODUCT_SHOW_PATH,
   MetaService) ->
    BusinessItemLoader.initialize(
      ProductFactory, $stateParams.id, $scope)
    SimilarItemsLoader.initialize(
        ProductFactory, $stateParams.id, $scope, PRODUCT_SHOW_PATH)
    PrevItemLoader.initialize(
        ProductFactory, $stateParams.id, $scope)
    NextItemLoader.initialize(
        ProductFactory, $stateParams.id, $scope)

    # set meta tags
    ProductFactory.get({ id: $stateParams.id },
      (attributes) ->
        businessItem = ProductFactory.buildPresenter(attributes)
        businessItemName = businessItem.attributes.name
        businessItemCountry = businessItem.attributes.business.country
        businessItemCategories = MetaService.getCategories(businessItem.attributes.breadcrumbs)

        businessItemtitle = businessItemName + ' in ' + businessItemCountry + ' | ' + businessItemCategories

        MetaService.set businessItemtitle, businessItem.attributes.description,
          businessItemtitle
    )
]
