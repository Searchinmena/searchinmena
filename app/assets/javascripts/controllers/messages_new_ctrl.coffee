@Sim.controller 'MessagesNewCtrl', ['$scope', 'Message', 'businessId',
  '$modalInstance', 'TranslatedFlash',
  ($scope, Message, businessId, $modalInstance, TranslatedFlash) ->
    $scope.message = new Message()

    $scope.submit = (e) ->
      e.preventDefault()
      $scope.message.$save({ business_id: businessId }, ->
        TranslatedFlash.success("messages.new.success")
        $modalInstance.close()
      ,
      (response) ->
        $scope.errors = response.data
      )

    $scope.cancel = ->
      $modalInstance.dismiss('cancel')
]
