class SIM.ProductPresenter extends SIM.BusinessItemPresenter
  showPath: ->
    "product({ id: #{@get('id')} })"

@Sim.value('ProductPresenter', SIM.ProductPresenter)
