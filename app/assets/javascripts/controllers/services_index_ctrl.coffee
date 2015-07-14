@Sim.controller 'ServicesIndexCtrl', ['$scope', 'BusinessItemsLoader',
  ($scope, BusinessItemsLoader) ->
    SERVICES_PATH = "/services"

    BusinessItemsLoader.initialize(SERVICES_PATH, $scope)
]
