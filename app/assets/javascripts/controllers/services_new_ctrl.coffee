@Sim.controller 'ServicesNewCtrl', ['$scope', 'BusinessItemCreator', 'selectsLoader',
  ($scope, BusinessItemCreator, selectsLoader) ->
    RESOURCE_NAME = 'services'
    PHOTOS_PATH = '/service_photos'

    BusinessItemCreator.initialize($scope, selectsLoader, RESOURCE_NAME, PHOTOS_PATH)
]

