@Sim.controller 'CompanyCtrl', ['$scope',
  ($scope) ->
    tabs = [ 'basic_info', 'trade_details', 'certifications' ]

    $scope.tabs = for tab in tabs
      new SIM.Tab("company.#{tab}", "company.tabs.#{tab}")
]
