@Sim.controller 'PhotosCtrl', ['$rootScope', '$scope', 'TranslatedFlash', 'PhotosValidator',
  ($rootScope, $scope, TranslatedFlash, PhotosValidator) ->

      $scope.photosRequested = ->
        $rootScope.$broadcast("photos_response", $scope.photos)

      $rootScope.$on("photos_request", $scope.photosRequested)
]
