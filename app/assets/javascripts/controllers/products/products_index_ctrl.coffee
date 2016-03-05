@Sim.controller 'ProductsIndexCtrl', ['$scope', 'BusinessItemsLoader', 'ProductFactory', '$http', 'USER_BUSINESS_PATH',
  ($scope, BusinessItemsLoader, ProductFactory, $http, USER_BUSINESS_PATH) ->
    $http.get(USER_BUSINESS_PATH).success((businessAttributes) ->
      $scope.business = businessAttributes
      BusinessItemsLoader.initialize(ProductFactory, $scope)
    )

]
