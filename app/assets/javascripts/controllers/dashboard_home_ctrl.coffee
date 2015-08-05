@Sim.controller 'DashboardHomeCtrl', ['$scope', '$http', 'USER_BUSINESS_PATH',
  ($scope, $http, USER_BUSINESS_PATH) ->
    $http.get(USER_BUSINESS_PATH).success((businessAttributes) ->
      $scope.business = businessAttributes
    )
]
