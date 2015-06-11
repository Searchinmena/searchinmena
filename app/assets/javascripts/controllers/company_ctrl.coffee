@Sim.controller 'CompanyCtrl', ['$scope', '$state'
  ($scope, $state) ->
    $state.transitionTo('company.basic-info')
]
