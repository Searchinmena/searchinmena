@Sim.controller 'ProductsNewCtrl', ['$scope', 'BusinessItemSaver',
  'ProductFactory', 'TranslatedFlash', 'selectsLoader', '$location','$http', 'USER_BUSINESS_PATH', 'DASHBOARD_PATH'
  ($scope, BusinessItemSaver, ProductFactory, TranslatedFlash, selectsLoader, $location, $http, USER_BUSINESS_PATH, DASHBOARD_PATH) ->
    $http.get(USER_BUSINESS_PATH).success((businessAttributes) ->
      if businessAttributes.can_add_products
        $scope.businessItem = ProductFactory.build()
        BusinessItemSaver.initialize(
          $scope, selectsLoader, ProductFactory.resourceName(),
          'ProductCategoriesCtrl')
      else
        $location.path(DASHBOARD_PATH);
        TranslatedFlash.error("products.limit")
    )
]
