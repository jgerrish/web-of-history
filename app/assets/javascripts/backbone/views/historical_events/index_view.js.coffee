WebOfHistory.Views.HistoricalEvents ||= {}

class WebOfHistory.Views.HistoricalEvents.IndexView extends Backbone.View
  #el: "#historical-events"

  template: JST["backbone/templates/historical_events/index"]

  initialize: (options) ->
    @options = options
    @options.historical_events.bind('reset', @addAll)

  addAll: () =>
    @options.historical_events.each(@addOne)

  addOne: (historicalEvent) =>
    view = new WebOfHistory.Views.HistoricalEvents.HistoricalEventView({model : historicalEvent})
    @$("tbody").append(view.render().el)

  render: =>
    @$el.html(@template(historical_events: @options.historical_events.toJSON() ))
    @addAll()

    return this
