@Sim.factory 'SimilarServices', ['$resource',
  ($resource) ->
    $resource('/services/:id/related_items', { id: '@id' })
]
