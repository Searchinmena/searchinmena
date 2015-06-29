# Based on: http://jsfiddle.net/jaredwilli/vUSPu/

@Sim.directive "multiselect", ->
  restrict: "E"
  templateUrl: "/assets/templates/multiselect"
  scope:
    model: "="
    options: "="
    pre_selected: "=preSelected"
    select_button_text: "=selectButtonText"

  controller: ($scope) ->
    $scope.isDropdownVisible = false
    $scope.options = {}

    $scope.toggleSelect = () ->
      $scope.isDropdownVisible = !$scope.isDropdownVisible

    $scope.selectAll = ->
      $scope.model = _.pluck($scope.options, "id")
      console.log $scope.model

    $scope.deselectAll = ->
      $scope.model = []
      console.log $scope.model

    $scope.setSelectedItem = ->
      id = @option.id
      if _.contains($scope.model, id)
        $scope.model = _.without($scope.model, id)
      else
        $scope.model.push id
      console.log $scope.model
      false

    $scope.isChecked = (id) ->
      return "icon-ok"  if _.contains($scope.model, id)
      false

    $scope.displayButtonText = () ->
      options = $scope.options
      ids = $scope.model
      names = (option.label for option in options when option.id in ids)

      if names.length == 0
        "-- " + $scope.select_button_text + " --"
      else
        names.join(", ")
