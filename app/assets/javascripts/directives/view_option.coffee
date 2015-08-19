@Sim.directive 'viewOption', ->
  restrict: 'E'
  replace: true
  templateUrl: 'components/view_option.html'
  scope:
    type: '@'
    selected: '='

  link: ($scope) ->
    $scope.isActive = (type, selected) ->
      selected == type

    $scope.select = ->
      $scope.selected = $scope.type
