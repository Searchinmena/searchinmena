@Sim = angular.module('sim', ['ui.router', 'pascalprecht.translate', 'ngSanitize',
  'ngTagsInput', 'ngAnimate', 'ngCookies', 'flash', 'ngFileUpload'])

@Sim.TRANSLATION_DIRS = ['products', 'company']

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

window.SIM = {}
