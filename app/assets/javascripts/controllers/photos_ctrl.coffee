@Sim.controller 'PhotosCtrl', ['$rootScope', '$scope', 'TranslatedFlash', 'PhotosValidator',
  ($rootScope, $scope, TranslatedFlash, PhotosValidator) ->
      $scope.removePhoto = (photo) ->
        index = $scope.photos.indexOf(photo)
        $scope.photos.splice(index, 1)
]
