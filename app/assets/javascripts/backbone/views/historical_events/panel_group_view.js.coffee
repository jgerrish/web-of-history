WebOfHistory.Views.HistoricalEvents ||= {}

class WebOfHistory.Views.HistoricalEvents.PanelGroupView extends Backbone.Marionette.CollectionView
  #el: "#layers-accordion"

  itemView: WebOfHistory.Views.HistoricalEvents.HistoricalEventPanelView

  initialize: (options) ->
    @options = options
    @collection = options.collection
    @options.historical_events.bind('reset', @addAll)

#  addAll: () =>
#    @options.historical_events.each(@addOne)

#  addOne: (historicalEvent) =>
#    view = new WebOfHistory.Views.HistoricalEvents.HistoricalEventPanelView({model : historicalEvent})
#    @$el.append(view.render().el)

  #render: =>
  #  @$el.find("").html(@template(historical_events: @options.historical_events.toJSON() ))
  #  @addAll()

  #  return this
