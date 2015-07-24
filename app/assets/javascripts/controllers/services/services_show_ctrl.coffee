@Sim.controller 'ServicesShowCtrl', ['$scope', '$stateParams',
  'BusinessItemLoader', 'ServiceFactory',
  ($scope, $stateParams, BusinessItemLoader, ServiceFactory) ->
    BusinessItemLoader.initialize(
      ServiceFactory, $stateParams.id, $scope)
]
