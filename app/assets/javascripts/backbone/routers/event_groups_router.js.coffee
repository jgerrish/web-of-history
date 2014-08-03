class WebOfHistory.Routers.EventGroupsRouter extends Backbone.Router
  initialize: (options) ->
    WebOfHistory.EventAggregator = new Backbone.Wreqr.EventAggregator()
    @event_aggregator = WebOfHistory.EventAggregator

    @historical_locations = new WebOfHistory.Collections.HistoricalLocationsCollection(event_aggregator: @event_aggregator)
    @historical_locations.reset options.historical_locations
    @shapefiles = new WebOfHistory.Collections.ShapefilesCollection(event_aggregator: @event_aggregator)
    @shapefiles.reset options.shapefiles
    @map = new WebOfHistory.Models.Map(locations: @historical_locations, \
                                       shapefiles: @shapefiles)

  routes:
    "new"      : "newHistoricalLocation"
    "index"    : "index"
    "event_groups/:id/map"      : "map"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newHistoricalLocation: ->
    @view = new WebOfHistory.Views.HistoricalLocations.NewView(collection: @historical_locations)
    $("#historical_locations").html(@view.render().el)

  index: ->
    @view = new WebOfHistory.Views.HistoricalLocations.IndexView(historical_locations: @historical_locations)
    $("#historical_locations").html(@view.render().el)

  map: (id) ->
    testView = WebOfHistory.Views.EmptyBox.CheckboxListView.extend({id: "historical-locations-list"})
    @view = new testView(checkboxes: @historical_locations)
    $("#historical_locations").html(@view.render().el)

    @chart_view = new WebOfHistory.Views.Viz.LineChartView(map_el: $("#map-chart"), id: "map-chart")
    $("#map-chart").html(@chart_view.render().el)

    @shapefiles_view = new WebOfHistory.Views.EmptyBox.CheckboxListView(checkboxes: @shapefiles, listid: "historical-events-list")
    $("#layers-accordion").html(@shapefiles_view.render().el)
    #@panel_view = new WebOfHistory.Views.HistoricalLocations.PanelGroupView(historical_locations: @historical_locations, collection: @historical_locations)
    #$("#layers-accordion").html(@panel_view.render().el)

    @map_view = new WebOfHistory.Views.EmptyBox.MapView(map: @map)

  show: (id) ->
    historical_location = @historical_locations.get(id)

    @view = new WebOfHistory.Views.HistoricalLocations.ShowView(model: historical_location)
    $("#historical_locations").html(@view.render().el)

  edit: (id) ->
    historical_location = @historical_locations.get(id)

    @view = new WebOfHistory.Views.HistoricalLocations.EditView(model: historical_location)
    $("#historical_locations").html(@view.render().el)
