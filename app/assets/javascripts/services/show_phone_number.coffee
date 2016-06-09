@Sim.service 'ShowPhoneNumber', [
  () ->
    initialize: (value, scope) ->
      scope.showPhoneNumber = value
]
