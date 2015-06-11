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
      .state('company.basic-info',
        templateUrl: '/assets/templates/company/basic-info',
      )
      .state('company.trade-details',
        url: '/trade-details',
        templateUrl: '/assets/templates/company/trade-details'
      )
      .state('company.certifications',
        url: '/certifications',
        templateUrl: '/assets/templates/company/certifications'
      )
    $urlRouterProvider.otherwise('/')
]
