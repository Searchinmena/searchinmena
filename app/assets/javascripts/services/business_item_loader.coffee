@Sim.service 'BusinessItemLoader', [
  ->
    initialize: (businessItemFactory, id, scope) ->
      businessItemFactory.get({ id: id },
        (attributes) ->
          scope.businessItem = new SIM.BusinessItem(attributes)
      )
]
