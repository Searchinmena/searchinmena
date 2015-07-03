@Sim.controller 'CompanyCtrl', ['$scope', '$state',
  ($scope, $state) ->
    if $state.current.url == '/company'
      $state.transitionTo('company.basic_info')

    tabs = [ 'basic_info', 'trade_details', 'certifications' ]

    $scope.tabs = for tab in tabs
      new SIM.Tab("company.#{tab}", "company.tabs.#{tab}")
]
