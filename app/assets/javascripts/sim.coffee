@Sim = angular.module('sim', ['ui.router', 'templates', 'pascalprecht.translate', 'ngSanitize',
  'ngTagsInput', 'ngAnimate', 'ngResource', 'ngCookies', 'flash', 'ngFileUpload', 'ui.bootstrap',
  'offClick', 'angularUtils.directives.dirPagination', 'bootstrapLightbox', 'truncate'])

@Sim.SCROLL_TO_TOP_SPEED = 300

@Sim.config(['$translateProvider', 'paginationTemplateProvider', 'LightboxProvider',
  ($translateProvider, paginationTemplateProvider, LightboxProvider) ->
    $translateProvider.useStaticFilesLoader(
      prefix: "/assets/locales/",
      suffix: '.json'
    )

    $translateProvider.determinePreferredLanguage(->
      $.cookie("locale")
    )
    $translateProvider.useSanitizeValueStrategy('sanitizeParameters')

    paginationTemplateProvider.setPath('components/pagination.html')
    LightboxProvider.templateUrl = 'components/lightbox.html'
])

@Sim.run(['$rootScope', '$http', 'GoogleAnalyticsTrack', ($rootScope, $http, GoogleAnalyticsTrack) ->
  $rootScope.$on('$viewContentLoaded', ->
    $('html, body').animate({ scrollTop: 0 }, @Sim.SCROLL_TO_TOP_SPEED)
  )
  GoogleAnalyticsTrack.run()
  $rootScope.$on '$stateChangeSuccess', (event) ->
    GoogleAnalyticsTrack.preview()

  $http.defaults.headers.common['Accept'] = 'application/json'
  $http.defaults.headers.common['Content-Type'] = 'application/json'
])

window.SIM = {}
