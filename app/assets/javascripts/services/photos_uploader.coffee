@Sim.service 'PhotosUploader', ['Upload', '$q',
  (Upload, $q) ->
    upload: (path, photos, businessItemId, success, error) ->
      @errors = {}

      promises = for photo in photos
        Upload.upload(
          url: path,
          fields: { 'business_item_id': businessItemId },
          file: photo
        ).error((data) =>
          @errors[data.file_name] = data.errors
        ).then()

      $q.all(promises).then(success, =>
        error(@errors)
      )
]
