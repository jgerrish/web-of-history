WebOfHistory.Views.HistoricalLocations ||= {}

class WebOfHistory.Views.HistoricalLocations.IndexView extends Backbone.View
  #el: "#historical-locations"

  template: JST["backbone/templates/historical_locations/index"]

  initialize: (options) ->
    @options = options
    @options.historical_locations.bind('reset', @addAll)

  addAll: () =>
    @options.historical_locations.each(@addOne)

  addOne: (historicalLocation) =>
    view = new WebOfHistory.Views.HistoricalLocations.HistoricalLocationView({model : historicalLocation})
    @$("tbody").append(view.render().el)

  render: =>
    @$el.html(@template(historical_locations: @options.historical_locations.toJSON() ))
    @addAll()

    return this
