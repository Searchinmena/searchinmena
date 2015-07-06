@Sim.controller 'PhotosCtrl', ['$rootScope', '$scope', 'TranslatedFlash', 'PhotosValidator',
  ($rootScope, $scope, TranslatedFlash, PhotosValidator) ->

      $scope.photosRequested = ->
        if PhotosValidator.validate($scope)
          $rootScope.$broadcast("photos_response", $scope.photos)
        else
          TranslatedFlash.error("products.adding_failed")

      $rootScope.$on("photos_request", $scope.photosRequested)

      $scope.removePhoto = (photo) ->
        index = $scope.photos.indexOf(photo)
        $scope.photos.splice(index, 1)
]
