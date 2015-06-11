@Sim.config ['$stateProvider', '$urlRouterProvider',
  ($stateProvider, $urlRouterProvider) ->
    $stateProvider
      .state('dashboard',
        url: '/',
        templateUrl: '/assets/templates/dashboard',
        controller: 'DashboardCtrl'
      )
      .state('products',
        url: '/products',
        templateUrl: '/assets/templates/products/index',
        controller: 'ProductsIndexCtrl'
      )
      .state('products/new',
        url: '/products/new',
        templateUrl: '/assets/templates/products/new',
        controller: 'ProductsNewCtrl'
      )
      .state('company',
        url: '/company',
        templateUrl: '/assets/templates/company/index',
        controller: 'CompanyCtrl'
      )
    $urlRouterProvider.otherwise('/')
]
