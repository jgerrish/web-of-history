WebOfHistory.Views.EmptyBox ||= {}

# The MapView class provides a Backbone View for mapping
#
# The initialize function expects a Map model.
# The map model has two main attributes:
# a locations collection and an optional layers collection.
#
# Each model in the locations collection should have the following attributes:
#   title: name or title of the location
#   lat: latitude of the location
#   lon: longitude of the location
#
# The layers collection should be a ShapefilesCollection
class WebOfHistory.Views.EmptyBox.MapView extends Backbone.View
  initialize: (options) ->
    @options = options
    if @options.map
      @map_data = options.map
    if @options.locations
      console.log "found locations!"
      @collection = @options.locations

    tm = _.bind(this.toggleMarker, this)
    WebOfHistory.EventAggregator.on "historical_location:toggled", (model) ->
      tm(model)

    tl = _.bind(this.toggleLayer, this)
    WebOfHistory.EventAggregator.on "shapefile:toggled", (model) ->
      tl(model)

    # This doesn't seem right, investigate if Marionette has a way of binding
    newfunc = _.bind(this.initMap, this, this)
    WebOfHistory.EventAggregator.bind "init_finished", newfunc

  events:
    "click .destroy" : "destroy"

  initMap: () ->
    L.Icon.Default.imagePath = "/assets/leaflet/"

    this.map = L.map('map').setView([51.505, -0.09], 2)

    L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
      attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
    }).addTo(this.map)
    this.map.setView(new L.LatLng(47.616347,-122.332871), 12)

    this.initMarkers()
    this.initShapefiles()

  initShapefiles: () ->
    map = this.map

    # Add shapefiles to the map
    if @map_data and @map_data.has('shapefiles')
      shapefiles = @map_data.get('shapefiles').pluck("id")

      @layers = {}
      layers = @layers
      shapefiles.forEach (element, index, array) ->
        layers[element] = L.geoJson(window.shapefiles[element]).addTo(map)

    return

  initMarkers: () ->
    map = this.map
    @markers = {}
    markers = @markers
    if @map_data and @map_data.has('locations')
      @map_data.get('locations').each (elem) ->
        markers[elem.get('id')] = new L.marker([elem.get('lat'), elem.get('lon')])
        markers[elem.get('id')].addTo(map).bindPopup(elem.get('title'))

  toggleMarker: (model) ->
    console.log('model id:')
    console.log(model.get('id'))
    if model.get('id') of @markers
      if model.isActive()
        this.map.addLayer(@markers[model.get('id')])
      else
        this.map.removeLayer(@markers[model.get('id')])

  toggleLayer: (model) ->
    console.log('toggle layer model id:')
    console.log(model.get('id'))
    if model.get('id') of @layers
      if model.isActive()
        this.map.addLayer(@layers[model.get('id')])
      else
        this.map.removeLayer(@layers[model.get('id')])

  render: ->
    return this
