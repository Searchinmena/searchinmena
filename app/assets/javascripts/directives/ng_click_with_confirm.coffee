@Sim.directive 'ngClickWithConfirm', ['$modal', '$timeout', ($modal, $timeout) ->
  restrict: 'A'
  link: (scope, element, attrs) ->
    element.bind 'click', ->
      modalInstance = $modal.open(
        templateUrl: 'confirmation_modal.html',
        controller: 'ConfirmationCtrl',
        animation: false,
        size: 'lg'
      )
      modalInstance.result.then(->
        $timeout( ->
          scope.$apply(attrs.ngClickWithConfirm)
        )
      )
]
