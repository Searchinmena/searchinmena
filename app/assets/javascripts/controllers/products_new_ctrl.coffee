@Sim.controller 'ProductsNewCtrl', ['$scope', '$http', 'SelectsLoader',
  'PhotosUploader', ($scope, $http, SelectsLoader, PhotosUploader) ->
    $scope.form = {}
    $scope.errors = {}
    $scope.form.attributes = [new SIM.Attribute()]

    SelectsLoader.loadSelectsData($scope)

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

      PhotosUploader.upload($scope.photos)
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
