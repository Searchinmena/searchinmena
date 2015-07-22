@Sim.controller 'ProductsShowCtrl', ['$scope', '$stateParams',
  'BusinessItemLoader', 'ProductFactory',
  ($scope, $stateParams, BusinessItemLoader, ProductFactory) ->
    BusinessItemLoader.initialize(
      ProductFactory, $stateParams.id, $scope)
]
