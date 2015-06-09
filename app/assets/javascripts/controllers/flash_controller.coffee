@Sim.controller 'FlashCtrl', ['$scope', 'SmartFlash',
  ($scope, SmartFlash) ->
    $scope.init = (railsFlash) ->
      railsFlash = JSON.parse(railsFlash)

      SmartFlash.success(railsFlash.notice) if railsFlash.notice
      SmartFlash.warning(railsFlash.warning) if railsFlash.warning
      SmartFlash.error(railsFlash.alert) if railsFlash.alert
      SmartFlash.error(railsFlash.error) if railsFlash.error
]
