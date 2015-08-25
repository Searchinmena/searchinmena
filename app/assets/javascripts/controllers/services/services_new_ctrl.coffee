@Sim.controller 'ServicesNewCtrl', ['$scope', 'BusinessItemSaver',
  'ServiceFactory', 'selectsLoader',
  ($scope, BusinessItemSaver, ServiceFactory, selectsLoader) ->
    $scope.businessItem = ServiceFactory.build()

    BusinessItemSaver.initialize(
      $scope, selectsLoader, ServiceFactory.resourceName(),
      'ServiceCategoriesCtrl')
]

