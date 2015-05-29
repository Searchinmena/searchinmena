@Sim.controller 'RegistrationsCtrl', ['$scope',
  ($scope) ->
    $scope.shouldShowCompanyInfo = (category) ->
      category == 'seller' || category == 'both'
]
