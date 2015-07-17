@Sim.controller 'ProductsShowCtrl', ['$scope', '$stateParams', 'BusinessItemLoader',
  ($scope, $stateParams, BusinessItemLoader) ->
    RESOURCE_NAME = "products"

    BusinessItemLoader.initialize(
      RESOURCE_NAME, $stateParams.id, $scope)
]
