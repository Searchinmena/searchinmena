class SIM.ServicePresenter extends SIM.BusinessItemPresenter
  showPath: ->
    "service({ id: #{@get('id')} })"

@Sim.value('ServicePresenter', SIM.ServicePresenter)
