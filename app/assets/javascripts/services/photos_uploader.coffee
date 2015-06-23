@Sim.service 'PhotosUploader', ['Upload', '$q',
  (Upload, $q) ->
    PRODUCT_PHOTOS_PATH = '/product_photos'

    upload: (photos, productId, success, error) ->
      @errors = {}

      promises = for photo in photos
        Upload.upload(
          url: PRODUCT_PHOTOS_PATH,
          fields: { 'product_id': productId },
          file: photo
        ).error((data) =>
          @errors[data.file_name] = data.errors
        ).then()

      $q.all(promises).then(success, =>
        error(@errors)
      )
]
