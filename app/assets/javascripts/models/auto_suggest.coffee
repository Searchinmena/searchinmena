@Sim.factory 'AutoSuggest', ['$resource',
  ($resource) ->
    AutoSuggest = $resource('/autosuggestion/', {}, {
      query: { method:'GET', isArray: false }
    })

    AutoSuggest
]
