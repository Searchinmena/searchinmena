@Sim.service 'NextItemLoader', ['$state',
  ($state) ->
    initialize: (businessItemFactory, id, scope) ->
      businessItemFactory.get_next({ id: id },
        (object) ->
          scope.nextItem = object.next_item
      )

]
