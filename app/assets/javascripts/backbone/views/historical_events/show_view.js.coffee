WebOfHistory.Views.HistoricalEvents ||= {}

class WebOfHistory.Views.HistoricalEvents.ShowView extends Backbone.View
  template: JST["backbone/templates/historical_events/show"]

  render: ->
    @$el.html(@template(@model.toJSON() ))
    return this
