@Sim.directive 'errorMessageFor', ->
  restrict: 'E',
  template: "<span class='error' ng-show='error'>{{error}}</span>",
  replace: true,
  scope: {
    error: '='
  }
