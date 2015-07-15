@Sim.controller 'ProductsIndexCtrl', ['$scope', 'BusinessItemsLoader',
  ($scope, BusinessItemsLoader) ->
    PRODUCTS_PATH = "/products"

    BusinessItemsLoader.initialize(PRODUCTS_PATH, $scope)
]
