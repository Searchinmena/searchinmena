@Sim.controller 'CategoriesCtrl', ['$scope', '$translate', '$modalInstance',
  ($scope, $translate, $modalInstance) ->
    $scope.setDefaultTitle = ->
      $translate("products.categories.choose").then((translation) ->
        $scope.title = translation
      )

    $scope.setDefaultTitle()

    $scope.subcategoriesFor = (category) ->
      $scope.subcategories[category.id.toString()]

    $scope.previous = (category) ->
      $scope.setDefaultTitle()
      $scope.categories = $scope.firstCategories

    $scope.next = (category) ->
      $scope.selectedCategory = category
      $scope.title = category.name
      $scope.categories = $scope.subcategoriesFor(category)

    $scope.ok = ->
      $modalInstance.close($scope.selectedCategory)

    $scope.cancel = ->
      console.log('canceling')
      $modalInstance.dismiss('cancel')

    categories = [
      "Agriculture"
      "Apparel"
      "Automobiles & Motorcycles"
      "Beauty & Personal Care"
      "Business Services"
      "Chemicals"
      "Construction & Real Estate"
      "Consumer Electronics"
      "Electrical Equipment & Supplies"
      "Electronic Components & Supplies"
      "Energy"
      "Fashion Accessories"
      "Food & Beverage"
      "Furniture"
      "Gifts & Crafts"
      "Hardware"
      "Health & Medical"
      "Home & Garden"
      "Home Appliances"
      "Lights & Lighting"
      "Luggage, Bags & Cases"
      "Machinery"
      "Measurement & Analysis Instrument"
      "Mechanical Parts & Fabrication Services"
      "Minerals & Metallurgy"
      "Office & School Supplies"
      "Packaging & Printing"
      "Rubber & Plastics"
      "Security Protection"
      "Service Equipment"
      "Shoes & Accessories"
      "Sports & Entertainment"
      "Textile & Leather Products"
    ]
    id = 0
    parentId = null
    $scope.firstCategories = for name in categories
      id += 1
      new SIM.Category(id, name, parentId)

    $scope.categories = $scope.firstCategories

    secondaryCategories = [
      "Agriculture 2"
      "Apparel 2"
      "Automobiles & Motorcycles 2"
      "Beauty & Personal Care 2"
      "Business Services 2"
      "Chemicals 2"
      "Construction & Real Estate 2"
      "Consumer Electronics 2"
      "Electrical Equipment & Supplies 2"
      "Electronic Components & Supplies 2"
      "Energy 2"
      "Fashion Accessories 2"
      "Food & Beverage 2"
      "Furniture 2"
      "Gifts & Crafts 2"
      "Hardware 2"
    ]

    id = 0
    parentId = 1
    secondaryCategories = for name in secondaryCategories
      id += 1
      new SIM.Category(id, name, parentId)

    $scope.subcategories = {
      "1": secondaryCategories
    }
]
