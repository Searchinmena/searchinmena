@Sim.controller 'ProductsIndexCtrl', ['$scope', 'BusinessItemsLoader',
  ($scope, BusinessItemsLoader) ->
    PRODUCTS_PATH = "/products"

    BusinessItemsLoader.load(PRODUCTS_PATH, $scope)
]
