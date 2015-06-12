@Sim = angular.module('sim', ['ui.router', 'pascalprecht.translate', 'ngSanitize',
  'ngTagsInput', 'ngAnimate', 'flash'])

@Sim.TAGS_PATH = "/api/tags"
@Sim.DASHBOARD_PATH = "/dashboard"

@Sim.TRANSLATION_DIRS = ['products']

@Sim.config(['$translateProvider', ($translateProvider) ->
  angular.forEach(@Sim.TRANSLATION_DIRS, (dir) ->
    $translateProvider.useStaticFilesLoader(
      prefix: "/assets/locales/#{dir}/",
      suffix: '.json'
    )
  )

  $translateProvider.preferredLanguage('en')
  $translateProvider.useSanitizeValueStrategy('sanitize')
])
