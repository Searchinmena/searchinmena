@Sim = angular.module('sim', ['ui.router', 'pascalprecht.translate', 'ngSanitize',
  'ngTagsInput', 'ngAnimate', 'ngCookies', 'flash', 'ngFileUpload', 'ui.bootstrap'])

@Sim.TRANSLATION_DIRS = ['products']
@Sim.SCROLL_TO_TOP_SPEED = 300

@Sim.config(['$translateProvider',
  ($translateProvider) ->
    angular.forEach(@Sim.TRANSLATION_DIRS, (dir) ->
      $translateProvider.useStaticFilesLoader(
        prefix: "/assets/locales/#{dir}/",
        suffix: '.json'
      )
    )

    $translateProvider.determinePreferredLanguage(->
      $.cookie("locale")
    )
    $translateProvider.useSanitizeValueStrategy('sanitize')
])

@Sim.run(['$rootScope', '$http', ($rootScope, $http) ->
  $rootScope.$on('$viewContentLoaded', ->
    $('html, body').animate({ scrollTop: 0 }, @Sim.SCROLL_TO_TOP_SPEED)
  )

  $http.defaults.headers.common['Accept'] = 'application/json'
  $http.defaults.headers.common['Content-Type'] = 'application/json'
])

window.SIM = {}
