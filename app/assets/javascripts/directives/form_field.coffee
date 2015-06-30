@Sim.directive 'formField', ->
  restrict: 'E',
  replace: true,
  transclude: true,
  templateUrl: '/assets/templates/form_field',
  scope: {
    error: '='
  }
  link: (scope, el, attrs) ->
    attrs.$set("class", attrs.class || "field")

