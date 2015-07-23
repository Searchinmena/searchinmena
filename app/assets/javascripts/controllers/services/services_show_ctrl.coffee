@Sim.controller 'ServicesShowCtrl', ['$scope', '$stateParams',
  'BusinessItemLoader', 'ServiceFactory',
  ($scope, $stateParams, BusinessItemLoader, ServiceFactory) ->
    $scope.service = BusinessItemLoader.initialize(
      ServiceFactory, $stateParams.id, $scope)
]
