class WebOfHistory.Routers.HistoricalLocationsRouter extends Backbone.Router
  initialize: (options) ->
    WebOfHistory.EventAggregator = new Backbone.Wreqr.EventAggregator()
    @event_aggregator = WebOfHistory.EventAggregator

    @historical_locations = new WebOfHistory.Collections.HistoricalLocationsCollection(event_aggregator: @event_aggregator)
    @historical_locations.reset options.historical_locations

  routes:
    "new"      : "newHistoricalLocation"
    "index"    : "index"
    "historical_locations/map"      : "map"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newHistoricalLocation: ->
    @view = new WebOfHistory.Views.HistoricalLocations.NewView(collection: @historical_locations)
    $("#historical_locations").html(@view.render().el)

  index: ->
    @view = new WebOfHistory.Views.HistoricalLocations.IndexView(historical_locations: @historical_locations)
    $("#historical_locations").html(@view.render().el)

  map: ->
    testView = WebOfHistory.Views.EmptyBox.CheckboxListView.extend({id: "historical-locations-list"})
    @view = new testView(checkboxes: @historical_locations)
    $("#historical_locations").html(@view.render().el)

    @chart_view = new WebOfHistory.Views.Viz.LineChartView(map_el: $("#map-chart"), id: "map-chart")
    $("#map-chart").html(@chart_view.render().el)

    @panel_view = new WebOfHistory.Views.EmptyBox.PanelGroupView(collection: @historical_locations)
    $("#layers-accordion").html(@panel_view.render().el)

    @map_view = new WebOfHistory.Views.EmptyBox.MapView(locations: @historical_locations)
    #$("#").html(@view.render().el)

  show: (id) ->
    historical_location = @historical_locations.get(id)

    @view = new WebOfHistory.Views.HistoricalLocations.ShowView(model: historical_location)
    $("#historical_locations").html(@view.render().el)

  edit: (id) ->
    historical_location = @historical_locations.get(id)

    @view = new WebOfHistory.Views.HistoricalLocations.EditView(model: historical_location)
    $("#historical_locations").html(@view.render().el)
