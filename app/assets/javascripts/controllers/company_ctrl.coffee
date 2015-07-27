@Sim.controller 'CompanyCtrl', ['$scope', '$state',
  ($scope, $state) ->
    tabs = [ 'basic_info', 'trade_details', 'certifications' ]

    $scope.tabs = for tab in tabs
      new SIM.Tab("company.#{tab}", "company.tabs.#{tab}")
]
