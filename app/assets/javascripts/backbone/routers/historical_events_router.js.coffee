class WebOfHistory.Routers.HistoricalEventsRouter extends Backbone.Router
  initialize: (options) ->
    WebOfHistory.EventAggregator = new Backbone.Wreqr.EventAggregator()
    @event_aggregator = WebOfHistory.EventAggregator

    @historical_events = new WebOfHistory.Collections.HistoricalEventsCollection(event_aggregator: @event_aggregator)
    @historical_events.reset options.historical_events
    col = new WebOfHistory.Collections.ShapefilesCollection()

    shapefiles = @historical_events.reduce (a, v) ->
        a.add(v.get('shapefiles').toJSON())
        return a
      , col

    @map = new WebOfHistory.Models.Map(locations: @historical_events, \
                                       shapefiles: shapefiles)

  routes:
    "new"      : "newHistoricalEvent"
    "index"    : "index"
    "historical_events/map"      : "map"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newHistoricalEvent: ->
    @view = new WebOfHistory.Views.HistoricalEvents.NewView(collection: @historical_events)
    $("#historical_events").html(@view.render().el)

  index: ->
    @view = new WebOfHistory.Views.HistoricalEvents.IndexView(historical_events: @historical_events)
    $("#historical_events").html(@view.render().el)

  map: ->
    testView = WebOfHistory.Views.EmptyBox.CheckboxListView.extend({id: "historical-events-list"})
    @view = new testView(checkboxes: @historical_events)
    $("#historical_events").html(@view.render().el)

    @panel_view = new WebOfHistory.Views.EmptyBox.PanelGroupView(historical_events: @historical_events, collection: @historical_events)
    $("#layers-accordion").html(@panel_view.render().el)

    @map_view = new WebOfHistory.Views.EmptyBox.MapView(map: @map)

  show: (id) ->
    historical_event = @historical_events.get(id)

    @view = new WebOfHistory.Views.HistoricalEvents.ShowView(model: historical_event)
    $("#historical_events").html(@view.render().el)

  edit: (id) ->
    historical_event = @historical_events.get(id)

    @view = new WebOfHistory.Views.HistoricalEvents.EditView(model: historical_event)
    $("#historical_events").html(@view.render().el)
