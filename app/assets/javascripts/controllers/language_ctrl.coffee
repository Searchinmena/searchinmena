@Sim.controller 'LanguageCtrl', ['$scope', 'language', '$window',
  ($scope, language, $window) ->
    $scope.changeLanguage = (e, langKey) ->
      e.preventDefault()

      language.set(langKey)
      $window.location.reload()
]
