@Sim.controller 'ServicesShowCtrl', ['$scope', '$stateParams', 'BusinessItemLoader',
  ($scope, $stateParams, BusinessItemLoader) ->
    RESOURCE_NAME = "services"

    BusinessItemLoader.initialize(
      RESOURCE_NAME, $stateParams.id, $scope)
]
