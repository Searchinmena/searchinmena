@Sim.service "PhotosValidator", ['$http', 'Upload', '$translate',
  ($http, Upload, $translate) ->
    MIN_PHOTOS_COUNT = 1
    MAX_PHOTOS_COUNT = 10

    validate: (scope, photos) ->
      if !photos || photos.length < MIN_PHOTOS_COUNT
        $translate("photos.at_least_one_photo",
          min_count: MIN_PHOTOS_COUNT
        ).then((translation) ->
          scope.errors["photos_general"] = translation
        )
        false
      else if photos.length > MAX_PHOTOS_COUNT
        $translate("photos.max_photos_exceeded",
          max_count: MAX_PHOTOS_COUNT
        ).then((translation) ->
          scope.errors["photos_general"] = translation
        )
        false
      else
        true
]
