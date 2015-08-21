#= require presenters/default_property_presenter

class SIM.PaymentTermsPresenter extends SIM.DefaultProperyPresenter
  display: ->
    @businessItem.get('payment_terms').join(" | ")

  isPresent: ->
    @businessItem.get(@property).length > 0
