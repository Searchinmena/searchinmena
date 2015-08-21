@Sim.controller 'ProductsIndexCtrl', ['$scope', 'BusinessItemsLoader', 'ProductFactory',
  ($scope, BusinessItemsLoader, ProductFactory) ->
    BusinessItemsLoader.initialize(ProductFactory, $scope)
]
