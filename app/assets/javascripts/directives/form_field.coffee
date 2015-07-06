@Sim.directive 'formField', ->
  restrict: 'E',
  replace: true,
  transclude: true,
  templateUrl: 'form_field.html',
  scope: {
    error: '='
  }
  link: (scope, el, attrs) ->
    attrs.$set("class", attrs.class || "field")

