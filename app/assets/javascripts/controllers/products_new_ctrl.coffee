@Sim.controller 'ProductsNewCtrl', ['$scope', '$http', '$state', 'TranslatedFlash',
  'SelectsLoader', 'PhotosValidator', 'PhotosUploader', 'CategoriesModal',
  ($scope, $http, $state, TranslatedFlash, SelectsLoader,
    PhotosValidator, PhotosUploader, CategoriesModal) ->
    $scope.form = {}
    $scope.errors = {}
    $scope.form.attributes = [new SIM.Attribute()]

    $scope.showCategories = CategoriesModal.activate

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

      unless PhotosValidator.validate($scope)
        TranslatedFlash.error("products.adding_failed")
        return

      # TODO: remove this after adding categories
      $scope.form ||= {}
      $scope.form.product ||= {}
      $scope.form.product.category_id = 7

      $http(
        url: e.target.action,
        data: $scope.form,
        method: 'POST'
      ).success((data) ->
        productId = data.id
        PhotosUploader.upload($scope.photos, productId,
          ->
            TranslatedFlash.success("products.successfully_added")
            $state.go("products")
          ,
          (errors) ->
            $scope.errors.photos = errors
            TranslatedFlash.error("products.adding_failed")
        )
      ).error((errors) ->
        $scope.errors = errors
        TranslatedFlash.error("products.adding_failed")
      )

      false
]
