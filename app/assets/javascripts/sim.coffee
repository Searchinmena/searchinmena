@Sim = angular.module('sim', ['ui.router', 'pascalprecht.translate', 'ngSanitize',
  'ngTagsInput', 'ngAnimate', 'ngCookies', 'flash', 'ngFileUpload'])

@Sim.config(['$translateProvider',
  ($translateProvider) ->
    $translateProvider.useStaticFilesLoader(
      prefix: "/assets/locales/",
      suffix: '.json'
    )

    $translateProvider.determinePreferredLanguage(->
      $.cookie("locale")
    )
    $translateProvider.useSanitizeValueStrategy('sanitize')
])

window.SIM = {}
