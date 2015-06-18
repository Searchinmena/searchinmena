@Sim.directive 'errorMessageFor', ->
  restrict: 'E',
  template: "<span class='error' ng-show='fieldName'>{{fieldName}}</span>",
  replace: true,
  transclude: false,
  scope: {
    fieldName: '='
  }
