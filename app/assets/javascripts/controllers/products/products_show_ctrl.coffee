@Sim.controller 'ProductsShowCtrl', ['$scope', '$stateParams',
  'BusinessItemLoader', 'ProductFactory',
  ($scope, $stateParams, BusinessItemLoader, ProductFactory) ->
    $scope.product = BusinessItemLoader.initialize(
      ProductFactory, $stateParams.id, $scope)
]
