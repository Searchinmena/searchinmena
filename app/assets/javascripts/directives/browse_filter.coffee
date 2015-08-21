@Sim.directive 'browseFilter', ['$state',
  ($state) ->
    restrict: 'E'
    replace: true
    transclude: true
    templateUrl: 'components/browse_filter.html'
    scope:
      search: '='
      type: '@'

    link: ($scope) ->
      $scope.browseFilterSelected = (type, search) ->
        search.type == type || !search.type && type == "all"

      $scope.browseFilterClicked = ->
        return if $scope.search.type == $scope.type

        $scope.search.type = $scope.type
        $state.go("results", $scope.search.toParams())
]

