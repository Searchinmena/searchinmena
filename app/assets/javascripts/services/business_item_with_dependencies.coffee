@Sim.service 'BusinessItemWithDependencies', ['Upload', '$q',
  (Upload, $q) ->
    create: (resourceName, businessItem, attributes, payment_terms, photos) ->
      return $q((resolve, reject) ->
        Upload.upload(
          url: "/#{resourceName}",
          fields: {business_item: businessItem, attributes: attributes, payment_terms: payment_terms},
          file: photos,
          fileFormDataName: _.map(photos, (photo, index) ->
            "file" + index
          )
        ).success(->
          resolve()
        ).error((data) ->
          reject(data)
        )
      )
]
