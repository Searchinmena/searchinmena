@Sim.controller 'ServicesNewCtrl', ['$scope', 'BusinessItemCreator', 'selectsLoader',
  ($scope, BusinessItemCreator, selectsLoader) ->
    RESOURCE_NAME = 'services'

    BusinessItemCreator.initialize($scope, selectsLoader, RESOURCE_NAME)
]

