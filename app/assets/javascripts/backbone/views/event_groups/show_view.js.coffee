WebOfHistory.Views.HistoricalLocations ||= {}

class WebOfHistory.Views.HistoricalLocations.ShowView extends Backbone.View
  template: JST["backbone/templates/historical_locations/show"]

  render: ->
    @$el.html(@template(@model.toJSON() ))
    return this
