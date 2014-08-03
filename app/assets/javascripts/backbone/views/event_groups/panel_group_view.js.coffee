WebOfHistory.Views.HistoricalLocations ||= {}

class WebOfHistory.Views.HistoricalLocations.PanelGroupView extends Backbone.Marionette.CollectionView
  #el: "#layers-accordion"

  itemView: WebOfHistory.Views.HistoricalLocations.HistoricalLocationPanelView

  initialize: (options) ->
    @options = options
    @collection = options.collection
    @options.historical_locations.bind('reset', @addAll)

#  addAll: () =>
#    @options.historical_locations.each(@addOne)

#  addOne: (historicalLocation) =>
#    view = new WebOfHistory.Views.HistoricalLocations.HistoricalLocationPanelView({model : historicalLocation})
#    @$el.append(view.render().el)

  #render: =>
  #  @$el.find("").html(@template(historical_locations: @options.historical_locations.toJSON() ))
  #  @addAll()

  #  return this
