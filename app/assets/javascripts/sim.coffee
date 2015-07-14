@Sim = angular.module('sim', ['ui.router', 'templates', 'pascalprecht.translate', 'ngSanitize',
  'ngTagsInput', 'ngAnimate', 'ngCookies', 'flash', 'ngFileUpload', 'ui.bootstrap', 'offClick',
  'angularUtils.directives.dirPagination'])

@Sim.SCROLL_TO_TOP_SPEED = 300

@Sim.config(['$translateProvider',
  ($translateProvider) ->
    $translateProvider.useStaticFilesLoader(
      prefix: "/assets/locales/",
      suffix: '.json'
    )

    $translateProvider.determinePreferredLanguage(->
      $.cookie("locale")
    )
    $translateProvider.useSanitizeValueStrategy('sanitizeParameters')
])

@Sim.run(['$rootScope', '$http', ($rootScope, $http) ->
  $rootScope.$on('$viewContentLoaded', ->
    $('html, body').animate({ scrollTop: 0 }, @Sim.SCROLL_TO_TOP_SPEED)
  )

  $http.defaults.headers.common['Accept'] = 'application/json'
  $http.defaults.headers.common['Content-Type'] = 'application/json'
])

window.SIM = {}
