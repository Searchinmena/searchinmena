@Sim.config ['$stateProvider', '$urlRouterProvider',
  ($stateProvider, $urlRouterProvider) ->
    $stateProvider.state('root',
      url: '/',
      templateUrl: 'home.html',
      controller: 'HomeCtrl'
    )
    .state('dashboard',
      url: '/dashboard',
      abstract: true,
      templateUrl: 'dashboard/layout.html',
      controller: 'DashboardCtrl'
    )
    .state('dashboard.home',
      url: '',
      templateUrl: 'dashboard/home.html',
      controller: 'DashboardHomeCtrl'
    )
    .state('dashboard.products',
      url: '/products',
      templateUrl: 'products/index.html',
      controller: 'ProductsIndexCtrl'
    )
    .state('dashboard.new_product',
      url: '/products/new',
      templateUrl: 'products/new.html',
      controller: 'ProductsNewCtrl'
    )
    .state('dashboard.services',
      url: '/services',
      templateUrl: 'services/index.html',
      controller: 'ServicesIndexCtrl'
    )
    .state('dashboard.new_service',
      url: '/services/new',
      templateUrl: 'services/new.html',
      controller: 'ServicesNewCtrl'
    )
    .state('dashboard.company',
      url: '/company',
      abstract: true,
      templateUrl: 'company/index.html',
      controller: 'CompanyCtrl'
    )
    .state('dashboard.company.basic_info',
      url: '/basic_info',
      templateUrl: 'company/basic_info.html',
      controller: 'CompanyBasicInfoCtrl'
    )
    .state('dashboard.company.trade_details',
      url: '/trade_details',
      templateUrl: 'company/trade_details.html',
      controller: 'CompanyTradeDetailsCtrl'
    )
    .state('dashboard.company.certifications',
      url: '/certifications',
      templateUrl: 'company/certifications.html',
      controller: 'CompanyCertificationsCtrl'
    )

    $stateProvider.state('product',
      url: '/products/:id',
      templateUrl: 'products/show.html',
      controller: 'ProductsShowCtrl'
    )
    $stateProvider.state('service',
      url: '/services/:id',
      templateUrl: 'services/show.html',
      controller: 'ServicesShowCtrl'
    )

    # Temporarily hidden
    # $stateProvider.state('browse',
    #   url: '/browse',
    #   templateUrl: 'browse.html'
    # )
    $stateProvider.state('results',
      url: '/results',
      templateUrl: 'results.html'
    )
    # TODO
    # it needs to be parametried with id,
    # but for now it's Gosia's mockup
    $stateProvider.state('company',
      url: '/company',
      templateUrl: 'company/show.html'
    )

    $urlRouterProvider.otherwise('/')
]

