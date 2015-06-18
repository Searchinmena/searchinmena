@Sim.service 'PhotosUploader', ['AwsUploader',
  (AwsUploader) ->
    key: (photo) ->
      "photos/#{photo.name}"

    upload: (photos) ->
      acl = 'private'
      callback = (data, status, headers, config) ->
        console.log('file ' + config.file.name + 'uploaded. Response: ' + data)

      AwsUploader.upload(photos, @key, acl, callback)
]
