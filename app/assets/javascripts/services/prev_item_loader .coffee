@Sim.service 'SimilarItemsLoader', ['$state',
  ($state) ->
    initialize: (businessItemFactory, id, scope,path) ->
      businessItemFactory.get_similar({ id: id },
        (object) ->
          scope.similar_items = object.similar_products
          scope.showpath = path;
        ,
        ->
          $state.go("root")
      )
]
