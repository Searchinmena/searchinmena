@Sim.service 'BusinessItemLoader', ['Business',  'SmartFlash', '$state',
  (Business, SmartFlash, $state) ->
    initialize: (businessItemFactory, id, scope) ->
      businessItemFactory.get({ id: id },
        (attributes) ->
          scope.businessItem = new SIM.BusinessItem(attributes)
          scope.business = Business.get({ id: attributes['business_id'] })
        ,
        ->
          $state.go("root")
      )
]
