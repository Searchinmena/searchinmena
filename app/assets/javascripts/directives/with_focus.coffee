@Sim.directive 'withFocus', ['$timeout', ($timeout) ->
  restrict: 'A',
  link: (scope, el, attrs) ->
    $timeout(->
      el[0].focus()
    )
]

