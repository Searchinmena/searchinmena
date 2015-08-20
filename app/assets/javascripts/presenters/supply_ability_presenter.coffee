#= require presenters/default_property_presenter

class SIM.SupplyAbilityPresenter extends SIM.DefaultProperyPresenter
  display: ->
    @businessItem.get('supply_ability_capacity') + " " +
      @businessItem.get('supply_ability_unit') + " / " +
      @businessItem.get('supply_ability_frequency')

