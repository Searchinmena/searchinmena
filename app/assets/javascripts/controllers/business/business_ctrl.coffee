@Sim.controller 'BusinessCtrl', ['$scope', 'CurrentUser',
  ($scope, CurrentUser) ->
    tabs = [ 'basic_info', 'trade_details', 'certifications' ]

    $scope.tabs = for tab in tabs
      new SIM.Tab("business.#{tab}", "business.tabs.#{tab}")

    $scope.currentUser = CurrentUser
]
