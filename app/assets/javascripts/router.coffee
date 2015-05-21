@Sim.config ['$stateProvider', '$urlRouterProvider',
  ($stateProvider, $urlRouterProvider) ->
    $stateProvider
      .state('dashboard',
        url: '/dashboard',
        templateUrl: '/assets/templates/dashboard',
        controller: 'DashboardCtrl'
      )
    $urlRouterProvider.otherwise('dashboard')
]
