@Sim.factory 'Product', ['$resource',
  ($resource) ->
    Product = $resource('/products/:id', { id: '@id' }, {
      get: { method:'GET', isArray: false },
      get_prev: {method:'GET', isArray: false, url: '/products/:id/prev_item'}
      get_next: {method:'GET', isArray: false, url: '/products/:id/next_item'}
    })
]
