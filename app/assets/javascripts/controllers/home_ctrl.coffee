@Sim.controller 'HomeCtrl', ['$scope', '$state', 'User', 'Search', 'SearchService',
                             '$controller',
  ($scope, $state, User, Search, SearchService, $controller) ->

    number = 1 + Math.floor(Math.random() * 51);
    $('.search-form').css('background-image', 'url("/images/slider/bg-homepage'+number+'.png")');
    $scope.number = number

    $controller('MetaCtrl').homeMeta()

    User.get((data) ->
      $scope.user = new User(data)
    )
    $scope.search = new Search(type: 'product')
    $scope.SearchService = SearchService

    $scope.submit = (e) ->
      e.preventDefault()
      $state.go("results", $scope.search.toParams())
]
