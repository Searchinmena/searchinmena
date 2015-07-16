@Sim.service "PhotosValidator", ['$http', 'Upload', '$translate',
  ($http, Upload, $translate) ->
    MIN_PHOTOS_COUNT = 1
    MAX_PHOTOS_COUNT = 10

    validate: (scope) ->
      if !scope.photos || scope.photos.length < MIN_PHOTOS_COUNT
        $translate("photos.at_least_one_photo",
          min_count: MIN_PHOTOS_COUNT
        ).then((translation) ->
          scope.errors["photos_general"] = translation
        )
        false
      else if scope.photos.length > MAX_PHOTOS_COUNT
        $translate("photos.max_photos_exceeded",
          max_count: MAX_PHOTOS_COUNT
        ).then((translation) ->
          scope.errors["photos_general"] = translation
        )
        false
      else
        res = true
        for photo in scope.photos
          if !photo.name.match(/\.(png|jpg|jpeg)$/)
            $translate("photos.valid_photos" ).then((translation) ->
              scope.errors["photos_general"] = translation
            )
            res &= false
        res
          
]
