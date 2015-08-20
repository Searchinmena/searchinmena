#= require presenters/default_property_presenter

class SIM.FobPricePresenter extends SIM.DefaultProperyPresenter
  display: ->
    @businessItem.get('fob_price') + " " +
      @businessItem.get('fob_price_currency') + " / " +
      @businessItem.get('fob_price_unit')

