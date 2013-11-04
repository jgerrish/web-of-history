WebOfHistory.Views.HistoricalEvents ||= {}

class WebOfHistory.Views.HistoricalEvents.MapView extends Backbone.View
  template: JST["backbone/templates/historical_events/historical_event_checkbox"]
  #el: '#map'

  initialize: (options) ->
    @options = options
    if @options.historical_events
      @collection = @options.historical_events

    tm = _.bind(this.toggleMarker, this)
    WebOfHistory.EventAggregator.on "historical_event:toggled", (model) ->
      tm(model)

    tl = _.bind(this.toggleLayer, this)
    WebOfHistory.EventAggregator.on "shapefile:toggled", (model) ->
      tl(model)

    # This doesn't seem right, investigate if Marionette has a way of binding
    newfunc = _.bind(this.initMap, this, this)
    WebOfHistory.EventAggregator.bind "init_finished", newfunc

  events:
    "click .destroy" : "destroy"

  #tagName: "li"

  initMap: () ->
    L.Icon.Default.imagePath = "/assets/leaflet/"

    this.map = L.map('map').setView([51.505, -0.09], 2)

    L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
      attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
    }).addTo(this.map)

    this.initMarkers()
    this.initShapefiles()

  initShapefiles: () ->
    map = this.map

    # Add shapefiles to the map
    shapefile_list = @collection.pluck("shapefiles")
    shapefiles = shapefile_list.map (s) ->
      id = s.pluck("id")
      return id
    shapefiles = _.flatten(shapefiles)

    @layers = {}
    layers = @layers
    shapefiles.forEach (element, index, array) ->
      layers[element] = L.geoJson(window.shapefiles[element]).addTo(map)
    return

  initMarkers: () ->
    map = this.map
    @markers = {}
    markers = @markers
    @options.historical_events.each (elem) ->
      markers[elem.get('id')] = new L.marker([elem.get('lat'), elem.get('lon')])
      markers[elem.get('id')].addTo(map).bindPopup(elem.get('title'))

  toggleMarker: (model) ->
    if model.isActive()
      this.map.addLayer(@markers[model.get('id')])
    else
      this.map.removeLayer(@markers[model.get('id')])

  toggleLayer: (model) ->
    if model.isActive()
      this.map.addLayer(@layers[model.get('id')])
    else
      this.map.removeLayer(@layers[model.get('id')])

  render: ->
    return this