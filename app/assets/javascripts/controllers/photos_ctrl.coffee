@Sim.controller 'PhotosCtrl', ['$rootScope', '$scope', 'TranslatedFlash', 'PhotosValidator', 'MIN_IMAGE_WIDTH', 'MIN_IMAGE_HEIGHT',
  ($rootScope, $scope, TranslatedFlash, PhotosValidator,
    MIN_IMAGE_WIDTH, MIN_IMAGE_HEIGHT) ->
      $scope.photoCommentTranslationData = {
        min_image_width: MIN_IMAGE_WIDTH,
        min_image_height: MIN_IMAGE_HEIGHT
      }

      $scope.removePhoto = (photo) ->
        index = $scope.businessItem.photos.indexOf(photo)
        $scope.businessItem.photos.splice(index, 1)
]
