@Sim.controller 'ServicesEditCtrl', ['$scope', 'BusinessItemCreator',
  'ServiceFactory', 'selectsLoader',
  ($scope, BusinessItemCreator, ServiceFactory, selectsLoader) ->
    RESOURCE_NAME = 'services'

    BusinessItemCreator.initialize(
      $scope, selectsLoader, RESOURCE_NAME,
      'ServiceCategoriesCtrl', ServiceFactory)
]

