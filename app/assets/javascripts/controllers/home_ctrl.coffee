@Sim.controller 'HomeCtrl', ['$scope', '$state', 'User', 'Search', 'SearchService',
                             'MetaService',
  ($scope, $state, User, Search, SearchService, MetaService) ->

    # Set meta tags
    pageTitle = 'Manufacturer, Trader, Supplier, Distributor in MENA'
    pageDescription = 'Largest B2B marketplace for Manufacturers, Traders, Suppliers, Distributors, & Wholesalers ' +
      'in Saudi, UAE, Turkey, & others Middle East & North Africa countries'
    pageKeywords = 'B2B marketplace, directory, Manufacturers, Traders, Suppliers, Distributors, Wholesalers, ' +
      'Saudi Arabia, UAE, Turkey, Morocco, Turkey, Qatar, Middle East, North Africa, Salim Akil'

    MetaService.set pageTitle, pageDescription, pageKeywords

    number = 1 + Math.floor(Math.random() * 51);
    $('.search-form').css('background-image', 'url("/images/slider/bg-homepage'+number+'.png")');
    $scope.number = number

    User.get((data) ->
      $scope.user = new User(data)
    )
    $scope.search = new Search(type: 'product')
    $scope.SearchService = SearchService

    $scope.submit = (e) ->
      e.preventDefault()
      $state.go("results", $scope.search.toParams())
]
