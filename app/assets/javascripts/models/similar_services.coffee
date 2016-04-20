@Sim.factory 'SimilarServices', ['$resource','FETCH_SIMILAR_SERVICES',
  ($resource,FETCH_SIMILAR_SERVICES) ->
    $resource(FETCH_SIMILAR_SERVICES, { id: '@id' })
]
