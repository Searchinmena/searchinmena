@Sim.service 'PrevItemLoader', ['$state',
  ($state) ->
    initialize: (businessItemFactory, id, scope) ->
      businessItemFactory.get_prev({ id: id },
        (object) ->
          scope.prevItem = object.prev_item
      )
]
