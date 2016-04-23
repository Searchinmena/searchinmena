@Sim.controller 'ServicesShowCtrl', ['$scope', '$stateParams',
  'BusinessItemLoader', 'ServiceFactory', '$controller','SimilarItemsLoader', 'PrevItemLoader',
   'NextItemLoader', 'SERVICE_SHOW_PATH',
  ($scope, $stateParams, BusinessItemLoader, ServiceFactory, $controller, SimilarItemsLoader,PrevItemLoader, NextItemLoader,
  SERVICE_SHOW_PATH) ->
    BusinessItemLoader.initialize(
      ServiceFactory, $stateParams.id, $scope)
    SimilarItemsLoader.initialize(
      ServiceFactory, $stateParams.id, $scope, SERVICE_SHOW_PATH)

    PrevItemLoader.initialize(
        ServiceFactory, $stateParams.id, $scope)
    NextItemLoader.initialize(
        ServiceFactory, $stateParams.id, $scope)

    $controller('MetaCtrl').serviceMeta($stateParams.id)
]
