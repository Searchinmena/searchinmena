@Sim.controller 'RegistrationsCtrl', ['$scope',
  ($scope) ->
    $scope.init = (userCategory) ->
      $scope.userCategory = userCategory

    $scope.shouldShowCompanyInfo = (category) ->
      category ||= $scope.userCategory
      category == "seller" || category == "both"
]
