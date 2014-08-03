WebOfHistory.Views.HistoricalLocations ||= {}

class WebOfHistory.Views.HistoricalLocations.HistoricalLocationView extends Backbone.View
  template: JST["backbone/templates/historical_locations/historical_location"]

  locations:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    @$el.html(@template(@model.toJSON() ))
    return this
