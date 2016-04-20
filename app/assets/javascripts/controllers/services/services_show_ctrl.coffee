@Sim.controller 'ServicesShowCtrl', ['$scope', '$stateParams',
  'BusinessItemLoader', 'ServiceFactory', '$controller','SimilarItemsLoader','SERVICE_SHOW_PATH',
  ($scope, $stateParams, BusinessItemLoader, ServiceFactory, $controller, SimilarItemsLoader,SERVICE_SHOW_PATH) ->
    BusinessItemLoader.initialize(
      ServiceFactory, $stateParams.id, $scope)
    SimilarItemsLoader.initialize(
      ServiceFactory, $stateParams.id, $scope, SERVICE_SHOW_PATH)
    $controller('MetaCtrl').serviceMeta($stateParams.id)
]
