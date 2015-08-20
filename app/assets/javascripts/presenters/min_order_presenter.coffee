#= require presenters/default_property_presenter

class SIM.MinOrderPresenter extends SIM.DefaultProperyPresenter
  display: ->
    @businessItem.get('min_order_quantity_number') + " " +
      @businessItem.get('min_order_quantity_unit')
