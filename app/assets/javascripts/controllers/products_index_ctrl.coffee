@Sim.controller 'ProductsIndexCtrl', ['$scope', '$http',
  ($scope, $http) ->
    PRODUCTS_PATH = "/products"

    $http.get(PRODUCTS_PATH)
      .success((data) ->
        $scope.products = for attributes in data
          new SIM.Product(attributes)
      )
]
