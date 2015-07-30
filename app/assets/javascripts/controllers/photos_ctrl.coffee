@Sim.controller 'PhotosCtrl', ['$rootScope', '$scope', 'TranslatedFlash', 'PhotosValidator',
  ($rootScope, $scope, TranslatedFlash, PhotosValidator) ->
      $scope.removePhoto = (photo) ->
        index = $scope.businessItem.photos.indexOf(photo)
        $scope.businessItem.photos.splice(index, 1)
]
