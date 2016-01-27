@Sim.controller 'ServicesShowCtrl', ['$scope', '$stateParams',
  'BusinessItemLoader', 'ServiceFactory', '$controller',
  ($scope, $stateParams, BusinessItemLoader, ServiceFactory, $controller) ->
    BusinessItemLoader.initialize(
      ServiceFactory, $stateParams.id, $scope)
    $controller('MetaCtrl').serviceMeta($stateParams.id)
]
