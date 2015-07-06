@Sim.config ['$stateProvider', '$urlRouterProvider',
  ($stateProvider, $urlRouterProvider) ->
    $stateProvider
      .state('dashboard',
        url: '/',
        templateUrl: "dashboard.html",
        controller: 'DashboardCtrl'
      )
      .state('products',
        url: '/products',
        templateUrl: "products/index.html",
        controller: 'ProductsIndexCtrl'
      )
      .state('new_product',
        url: '/products/new',
        templateUrl: "products/new.html",
        controller: 'ProductsNewCtrl'
      )
      .state('company',
        url: '/company',
        templateUrl: "company/index.html",
        controller: 'CompanyCtrl'
      )
      .state('company.basic_info',
        templateUrl: "company/basic_info.html",
        controller: 'CompanyBasicInfoCtrl'
      )
      .state('company.trade_details',
        url: '/trade_details',
        templateUrl: "company/trade_details.html",
        controller: "CompanyTradeDetailsCtrl"
      )
      .state('company.certifications',
        url: '/certifications',
        templateUrl: "company/certifications.html",
        controller: "CompanyCertificationsCtrl"
      )
    $urlRouterProvider.otherwise('/')
]

@Sim.DASHBOARD_PATH = "/dashboard"
@Sim.TAGS_PATH = "/tags"
