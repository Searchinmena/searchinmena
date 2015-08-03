@Sim.factory 'Business', ['$resource',
  ($resource) ->
    $resource('/businesses/:id', { id: '@id' })
]

