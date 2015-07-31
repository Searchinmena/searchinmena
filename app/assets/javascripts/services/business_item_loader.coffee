@Sim.service 'BusinessItemLoader', ['Business',
  (Business) ->
    initialize: (businessItemFactory, id, scope) ->
      businessItemFactory.get({ id: id },
        (attributes) ->
          scope.businessItem = new SIM.BusinessItem(attributes)
          scope.business = Business.get()
      )
]
