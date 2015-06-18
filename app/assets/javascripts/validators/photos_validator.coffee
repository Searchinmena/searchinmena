@Sim.service "PhotosValidator", ['$http', 'Upload', '$translate',
  ($http, Upload, $translate) ->
    MAX_PHOTOS_COUNT = 2

    validate: (scope) ->
      if scope.photos and scope.photos.length > 0 and scope.photos.length < MAX_PHOTOS_COUNT
        true
      else
        $translate("products.at_least_one_photo").then((translation) ->
          scope.errors["photos"] = translation
        )
        false
]
