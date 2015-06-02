@Sim.controller 'RegistrationsCtrl', ['$scope', '$http',
  ($scope, $http) ->
    $scope.init = (userCategory) ->
      $scope.userCategory = userCategory

    $scope.shouldShowCompanyInfo = (category) ->
      category ||= $scope.userCategory
      category == "seller" || category == "both"

    $scope.tags = [
      { text: 'just' },
      { text: 'some' },
      { text: 'cool' },
      { text: 'tags' }
    ]

    $scope.loadTags = (query) ->
      $http.get("#{window.Sim.TAGS_URL}?query=#{query}")
]
