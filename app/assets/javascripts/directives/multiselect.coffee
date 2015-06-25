# Based on: http://jsfiddle.net/jaredwilli/vUSPu/

@Sim.directive "multiselect", ->
  restrict: "E"
  scope:
    model: "="
    options: "="
    pre_selected: "=preSelected"
    select_button_text: "=selectButtonText"

  template: "<div ng-class='{open: open}'>" +
    "<a class='select-field' ng-click='toggleSelect();openDropdown()'>-- {{ select_button_text }} --</a>" +
    "<ul class='dropdown-menu' ng-show='isDropdownVisible'>" +
      "<li><a ng-click='selectAll()'><i class='icon-ok-sign'></i> {{ 'other.check_all' | translate }}</a></li>" +
      "<li><a ng-click='deselectAll();'><i class='icon-remove-sign'></i> {{ 'other.uncheck_all' | translate }}</a></li>" +
      "<li class='divider'></li>" +
      "<li ng-repeat='option in options'>
        <a ng-click='setSelectedItem()'>{{option.label}}
          <span ng-class='isChecked(option.id)'></span>
        </a>
      </li>" +
    "</ul>" +
  "</div>"
  controller: ($scope) ->
    $scope.isDropdownVisible = false

    $scope.openDropdown = ->
      window.options = $scope.options
      $scope.selected_items = []
      i = 0

      while i < $scope.pre_selected.length
        $scope.selected_items.push $scope.pre_selected[i].id
        i++

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

    $scope.toggleSelect = () ->
      $scope.isDropdownVisible = !$scope.isDropdownVisible
