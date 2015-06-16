@Sim.directive 'formField', ['$compile', ($compile) ->
  restrict: 'E',
  replace: true,
  transclude: true,
  template: "<div ng-transclude></div>",
  link: (scope, el, attrs) ->
    attrs.$set("class", attrs.class || "field")

    error = scope.$eval("errors.#{attrs.fieldName}")
    el.addClass('field-with-errors') if error

    el.append("<error-message-for field-name='#{attrs.fieldName}'></error-message-for>")
    $compile(el.contents())(scope)
]

@Sim.directive 'errorMessageFor', ->
  restrict: 'E',
  template: "<span class='error' ng-show='error'></span>",
  replace: true,
  transclude: false,
  link: (scope, el, attrs, ctrl) ->
    scope.error = scope.$eval("errors.#{attrs.fieldName}")
    el.text(scope.error)
