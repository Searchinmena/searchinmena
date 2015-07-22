@Sim.controller 'ServicesNewCtrl', ['$scope', 'BusinessItemCreator',
  'ServiceFactory', 'selectsLoader',
  ($scope, BusinessItemCreator, ServiceFactory, selectsLoader) ->
    RESOURCE_NAME = 'services'
    PHOTOS_PATH = '/service_photos'

    BusinessItemCreator.initialize(
      $scope, selectsLoader, RESOURCE_NAME, PHOTOS_PATH,
      'ServiceCategoriesCtrl', ServiceFactory)
]

