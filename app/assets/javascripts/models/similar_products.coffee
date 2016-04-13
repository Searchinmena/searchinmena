@Sim.factory 'SimilarProducts', ['$resource',
  ($resource) ->
    $resource('/products/:id/related_items', { id: '@id' })
]
