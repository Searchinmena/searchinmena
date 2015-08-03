@Sim.controller 'DashboardCtrl', ['$scope', '$http', 'CurrentUser', 'USER_BUSINESS_PATH',
  ($scope, $http, CurrentUser, USER_BUSINESS_PATH) ->
    CurrentUser.authorize($scope)

    $http.get(USER_BUSINESS_PATH).success((businessAttributes) ->
      $scope.business = businessAttributes
    )
]
