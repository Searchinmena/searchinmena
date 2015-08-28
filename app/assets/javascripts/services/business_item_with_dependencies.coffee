@Sim.service 'BusinessItemWithDependencies', ['Upload', '$q',
  (Upload, $q) ->
    create: (resourceName, businessItem, attributes, payment_terms, photos) ->
      photos = _(photos).select((photo, index) ->
        !photo.id
      )
      photosNames = _.map(photos, (photo, index) ->
        "file" + index
      )
      return $q((resolve, reject) ->
        Upload.upload(
          url: "/#{resourceName}",
          fields: {business_item: businessItem, attributes: attributes, payment_terms: payment_terms},
          file: photos,
          fileFormDataName: photosNames
        ).success(->
          resolve()
        ).error((data) ->
          reject(data)
        )
      )
]
