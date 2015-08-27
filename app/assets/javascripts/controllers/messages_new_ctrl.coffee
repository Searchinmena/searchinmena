@Sim.controller 'MessagesNewCtrl', ['$scope', 'Message', 'businessId',
  '$modalInstance', 'TranslatedFlash',
  ($scope, Message, businessId, $modalInstance, TranslatedFlash) ->
    $scope.message = new Message()

    $scope.submit = (e) ->
      $scope.loading = true

      e.preventDefault()
      $scope.message.$save({ business_id: businessId }, ->
        TranslatedFlash.success("messages.new.success")
        $scope.loading = false
        $modalInstance.close()
      ,
      (response) ->
        $scope.loading = false
        $scope.errors = response.data
      )

    $scope.cancel = ->
      $modalInstance.dismiss('cancel')
]
