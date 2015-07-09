@Sim.controller 'ServicesIndexCtrl', ['$scope', 'BusinessItemsLoader',
  ($scope, BusinessItemsLoader) ->
    SERVICES_PATH = "/services"

    BusinessItemsLoader.load(SERVICES_PATH, $scope)
]
