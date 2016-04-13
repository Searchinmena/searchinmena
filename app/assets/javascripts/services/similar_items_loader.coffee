@Sim.service 'SimilarItemsLoader', ['$state',
  ($state) ->
    initialize: (businessItemFactory, id, scope,path) ->
      debugger
      businessItemFactory.get_similar({ id: id },
        (object) ->
          debugger
          scope.similar_items = object.similar_products
          scope.showpath = path;
        ,
        ->
          $state.go("root")
      )

]
