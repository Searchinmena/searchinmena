# Based on: http://jsfiddle.net/jaredwilli/vUSPu/

@Sim.directive 'multiselect', ->
  restrict: 'E'
  templateUrl: 'multiselect.html'
  scope:
    model: '='
    options: '='
    selectButtonText: '=selectButtonText'

  link: ($scope) ->
    $scope.isDropdownVisible = false
    $scope.options = {}
    $scope.model = []

    $scope.toggleSelect = () ->
      $scope.isDropdownVisible = !$scope.isDropdownVisible

    $scope.hideDropdown = () ->
      $scope.isDropdownVisible = false

    $scope.selectAll = ->
      $scope.model = _.pluck($scope.options, 'id')

    $scope.deselectAll = ->
      $scope.model = []

    $scope.setSelectedItem = ->
      id = @option.id
      if _.contains($scope.model, id)
        $scope.model = _.without($scope.model, id)
      else
        $scope.model.push id
      false

    $scope.isChecked = (id) ->
      return true if _.contains($scope.model, id)
      false

    $scope.displayButtonText = () ->
      options = $scope.options
      ids = $scope.model
      names = (option.label for option in options when option.id in ids)

      if names.length == 0
        '-- ' + $scope.selectButtonText + ' --'
      else
        names.join(', ')
