@Sim.config ['$stateProvider', '$urlRouterProvider', '$locationProvider',
  ($stateProvider, $urlRouterProvider, $locationProvider) ->
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
      url: '/products?:page',
      templateUrl: 'products/index.html',
      controller: 'ProductsIndexCtrl'
    )
    .state('dashboard.new_product',
      url: '/products/new',
      templateUrl: 'products/new.html',
      controller: 'ProductsNewCtrl'
    )
    .state('dashboard.edit_product',
      url: '/products/:id/edit',
      templateUrl: 'products/edit.html',
      controller: 'ProductsEditCtrl'
    )
    .state('dashboard.services',
      url: '/services?:page',
      templateUrl: 'services/index.html',
      controller: 'ServicesIndexCtrl'
    )
    .state('dashboard.new_service',
      url: '/services/new',
      templateUrl: 'services/new.html',
      controller: 'ServicesNewCtrl'
    )
    .state('dashboard.edit_service',
      url: '/services/:id/edit',
      templateUrl: 'services/edit.html',
      controller: 'ServicesEditCtrl'
    )
    .state('dashboard.business',
      url: '/company',
      abstract: true,
      templateUrl: 'business/index.html',
      controller: 'BusinessCtrl'
    )
    .state('dashboard.business.basic_info',
      url: '/basic_info',
      templateUrl: 'business/basic_info.html',
      controller: 'BusinessBasicInfoCtrl'
    )
    .state('dashboard.business.trade_details',
      url: '/trade_details',
      templateUrl: 'business/trade_details.html',
      controller: 'BusinessTradeDetailsCtrl'
    )
    .state('dashboard.business.certifications',
      url: '/certifications',
      templateUrl: 'business/certifications.html',
      controller: 'BusinessCertificationsCtrl'
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
      url: '/results?:type&:query&:business_type&:country&:category&:page&:viewOption',
      templateUrl: 'search/results.html',
      controller: 'ResultsCtrl'
    )

    $stateProvider.state('categories',
      url: '/categories?:type',
      templateUrl: 'categories/index.html',
      controller: 'CategoriesCtrl'
    )

    $stateProvider.state('business',
      url: '/company/:id',
      templateUrl: 'business/show.html'
      controller: 'BusinessShowCtrl'
    )

    $locationProvider.html5Mode(true)
]
