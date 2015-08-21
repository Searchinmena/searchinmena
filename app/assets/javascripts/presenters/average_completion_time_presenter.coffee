#= require presenters/default_property_presenter

class SIM.AverageCompletionTimePresenter extends SIM.DefaultProperyPresenter
  display: ->
    @businessItem.get('average_completion_time') + " " +
      @businessItem.get('average_completion_time_unit')

