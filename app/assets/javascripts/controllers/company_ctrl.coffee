@Sim.controller 'CompanyCtrl', ['$scope', '$state'
  ($scope, $state) ->
    if $state.current.url == "/company"
      $state.transitionTo('company.basic-info')
]
