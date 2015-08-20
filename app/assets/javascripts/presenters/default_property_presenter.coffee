class SIM.DefaultProperyPresenter
  constructor: (property, businessItem) ->
    @property = property
    @businessItem = businessItem

  display: ->
    @businessItem.get(@property)

  isPresent: ->
    !!@businessItem.get(@property)
