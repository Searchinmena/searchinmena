@Sim.controller 'DashboardCtrl', ['$scope', 'sampleService',
  ($scope, sampleService) ->
    $scope.test = "Hello world! " + sampleService.randomNumber()
]
