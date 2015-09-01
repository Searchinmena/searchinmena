@Sim.service 'GoogleAnalyticsTrack', ['CurrentUser', '$location', '$window',
  (CurrentUser, $location, $window) ->
    testNumber: ->
      4 # ;)

    run: ->
        ga 'create', 'UA-18369665-1', 'auto'

    preview: ->
      if $window.ga
        $window.ga 'send', 'pageview', page: $location.absUrl()

    dimessions: ->
      #dimensionValue = CurrentUser
      #ga('set', 'dimension1', dimensionValue);
]