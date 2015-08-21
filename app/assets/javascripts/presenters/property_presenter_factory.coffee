#= require presenters/supply_ability_presenter
#= require presenters/average_completion_time_presenter
#= require presenters/fob_price_presenter
#= require presenters/payment_terms_presenter
#= require presenters/min_order_presenter

class SIM.PropertyPresenterFactory
  PRESENTERS = {
    supply_ability_capacity: SIM.SupplyAbilityPresenter
    average_completion_time: SIM.AverageCompletionTimePresenter
    fob_price: SIM.FobPricePresenter
    payment_terms: SIM.PaymentTermsPresenter
    min_order_quantity_number: SIM.MinOrderPresenter
  }
  build: (property, businessItem) ->
    klass = PRESENTERS[property] || SIM.DefaultProperyPresenter
    new klass(property, businessItem)
