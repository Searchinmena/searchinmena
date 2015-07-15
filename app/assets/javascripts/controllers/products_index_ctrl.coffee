@Sim.controller 'ProductsIndexCtrl', ['$scope', 'BusinessItemsLoader',
  ($scope, BusinessItemsLoader) ->
    RESOURCE_NAME = "products"

    BusinessItemsLoader.initialize(RESOURCE_NAME, $scope)
]
