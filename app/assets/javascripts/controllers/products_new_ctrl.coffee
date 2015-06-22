@Sim.controller 'ProductsNewCtrl', ['$scope', '$http', 'SelectsLoader',
  'PhotosValidator', 'PhotosUploader',
  ($scope, $http, SelectsLoader, PhotosValidator, PhotosUploader) ->
    $scope.form = {}
    $scope.errors = {}
    $scope.form.attributes = [new SIM.Attribute()]

    SelectsLoader.loadSelectsData($scope)

    $scope.removePhoto = (photo) ->
      index = $scope.photos.indexOf(photo)
      $scope.photos.splice(index, 1)

    $scope.addAttribute = ->
      $scope.form.attributes.push(new SIM.Attribute())

    $scope.removeAttribute = (attribute) ->
      index = $scope.form.attributes.indexOf(attribute)
      $scope.form.attributes.splice(index, 1)

    $scope.submit = (e) ->
      e.preventDefault()
      $scope.errors = {}

      console.log($scope.form)
      return unless PhotosValidator.validate($scope)

      $http(
        url: e.target.action,
        data: $scope.form,
        method: 'POST'
      ).success(->
        console.log("Successful product creation")

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

        # TOOD: take it from response
        productId = 4
        PhotosUploader.upload($scope.photos, productId,
          ->
            console.log("Successful upload")
          ,
          (errors) ->
            console.log("Upload failed")
            $scope.errors.photos = errors
        )
      ).error((errors) ->
        console.log("Product creation failed")
        console.log(errors)
        $scope.errors = errors
      )

      false
]
