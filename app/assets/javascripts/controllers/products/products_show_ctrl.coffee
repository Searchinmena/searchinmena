@Sim.controller 'ProductsShowCtrl', ['$scope', '$stateParams',
  'BusinessItemLoader', 'ProductFactory', '$controller',
  ($scope, $stateParams, BusinessItemLoader, ProductFactory, $controller) ->
    BusinessItemLoader.initialize(
      ProductFactory, $stateParams.id, $scope)
    $controller('MetaCtrl').productMeta($stateParams.id)
]
