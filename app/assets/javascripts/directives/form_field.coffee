@Sim.directive 'formField', ['$compile', ($compile) ->
  restrict: 'E',
  replace: true,
  transclude: true,
  template: "<div ng-transclude></div>",
  link: (scope, el, attrs) ->
    attrs.$set("class", attrs.class || "field")

    error = scope.$eval("errors.#{attrs.fieldName}")
    el.addClass('field-with-errors') if error

    el.append("<error-message-for field-name='errors.#{attrs.fieldName}'></error-message-for>")
    $compile(el.contents())(scope)
]
