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

      return unless PhotosValidator.validate($scope)

      # TODO: remove this after adding categories
      $scope.form.product.category_id = 7

      $http(
        url: e.target.action,
        data: $scope.form,
        method: 'POST'
      ).success((data) ->
        productId = data.id
        PhotosUploader.upload($scope.photos, productId,
          ->
            # TODO: add flash or redirect of whatever here instead
            console.log("Successful upload")
          ,
          (errors) ->
            $scope.errors.photos = errors
        )
      ).error((errors) ->
        $scope.errors = errors
      )

      false
]
