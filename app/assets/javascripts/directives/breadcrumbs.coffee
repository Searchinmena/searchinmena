@Sim.directive 'breadcrumbs', [
  ->
    restrict: 'E'
    replace: true
    templateUrl: 'components/breadcrumbs.html'
    scope:
      businessItem: '='
]

