WebOfHistory.Views.HistoricalEvents ||= {}

class WebOfHistory.Views.HistoricalEvents.CheckboxListView extends Backbone.View
  template: JST["backbone/templates/historical_events/checkbox_list"]

  initialize: (options) ->
    @options = options
    @options.historical_events.bind('reset', @addAll)

  addAll: () =>
    @options.historical_events.each(@addOne)

  addOne: (historicalEvent) =>
    view = new WebOfHistory.Views.HistoricalEvents.HistoricalEventCheckboxView({model : historicalEvent})
    @$("ul#historical-events-list").append(view.render().el)

  render: =>
    @$el.html(@template(historical_events: @options.historical_events.toJSON() ))
    @addAll()

    return this
