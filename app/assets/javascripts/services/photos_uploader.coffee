@Sim.service 'PhotosUploader', ['Upload',
  (Upload) ->
    PRODUCT_PHOTOS_PATH = '/product_photos'

    upload: (photos, productId) ->
      for photo in photos
        Upload.upload(
          url: PRODUCT_PHOTOS_PATH,
          fields: { 'product_id': productId },
          file: photo
        ).progress((evt) ->
          progressPercentage = parseInt(100.0 * evt.loaded / evt.total)
          console.log('progress: ' + progressPercentage + '% ' + evt.config.file.name)
        ).success((data, status, headers, config) ->
          console.log('file ' + config.file.name + 'uploaded. Response: ' + data)
        )
]
