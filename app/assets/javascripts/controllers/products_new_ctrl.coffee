@Sim.controller 'ProductsNewCtrl', ['$scope', '$http', 'language', 'Upload',
  ($scope, $http, language, Upload) ->
    $scope.form = {}
    $scope.errors = {}
    $scope.form.attributes = [new SIM.Attribute()]

    @loadDataForSelect = (path, callback) ->
      $http.get(path, { params: { locale: language.get() } }).success(callback)

    @loadDataForSelect(window.Sim.UNITS_PATH, (data) ->
      $scope.units = data
    )
    @loadDataForSelect(window.Sim.CURRENCIES_PATH, (data) ->
      $scope.currencies = data
    )
    @loadDataForSelect(window.Sim.FREQUENCIES_PATH, (data) ->
      $scope.frequencies = data
    )
    @loadDataForSelect(window.Sim.PAYMENT_TERMS_PATH, (data) ->
      $scope.payment_terms = data
    )

    $scope.MAX_PHOTOS_COUNT = 2

    $scope.validate = ->
      if $scope.photos and $scope.photos.length > 0 and $scope.photos.length < $scope.MAX_PHOTOS_COUNT
        true
      else
        $scope.errors["photos"] = "Error"
        false


    $scope.$watch('photos', (prev, current) ->
      return unless $scope.photos

      return unless $scope.validate()

      $scope.upload($scope.photos)
    )

    $http.get(window.Sim.AWS_PROPERTIES_PATH).success((data) ->
      $scope.policy = data['policy']
      $scope.signature = data['signature']
    )

    $scope.contentType = (photo) ->
      if photo.type != ''
        photo.type
      else
        'application/octet-stream'

    $scope.upload = (photos) ->
      for photo in photos
        Upload.upload(
          url: "https://#{window.Config.aws.bucket_name}.s3.amazonaws.com/",
          method: 'POST',
          fields: {
            key: "photos/#{photo.name}",
            AWSAccessKeyId: window.Config.aws.access_key_id,
            acl: 'private',
            policy: $scope.policy,
            signature: $scope.signature,
            "Content-Type": $scope.contentType(photo),
            filename: photo.name
          },
          file: photo,
        ).progress((evt) ->
          progressPercentage = parseInt(100.0 * evt.loaded / evt.total)
          console.log('progress: ' + progressPercentage + '% ' + evt.config.file.name)
        ).success((data, status, headers, config) ->
          console.log('file ' + config.file.name + 'uploaded. Response: ' + data)
        )

    $scope.addAttribute = ->
      $scope.form.attributes.push(new SIM.Attribute())

    $scope.removeAttribute = (attribute) ->
      index = $scope.form.attributes.indexOf(attribute)
      $scope.form.attributes.splice(index, 1)

    $scope.submit = (e) ->
      e.preventDefault()

      console.log($scope.form)
      return unless $scope.validate()

      $http(
        url: e.target.action,
        data: $scope.form,
        method: 'POST'
      ).success(->
        console.log("SUCCESS")
        $scope.errors = { product: {
          name: "can't be blank",
          category: "can't be blank",
          description: "too long",
          model_number: "too long",
          brand_name: "too long",
          min_order_quantity_number: "not a number",
          fob_price: "not a number",
          supply_ability_capacity: "not a number",
          port: "too long",
          packaging: "too long"
        } }
      ).error((errors) ->
        console.log(errors)
        $scope.errors = errors
      )

      false
]
