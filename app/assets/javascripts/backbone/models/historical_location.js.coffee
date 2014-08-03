class WebOfHistory.Models.HistoricalLocation extends Backbone.AssociatedModel
  paramRoot: 'historical_location'

  relations: [
      type: Backbone.Many
      key: 'shapefiles'
      relatedModel: 'WebOfHistory.Models.Shapefile'
    ,
  ]

  initialize: () ->
    console.log('HistoricalLocation model initialized')
    this.set('active', true)
    this.on "change:active", (model) ->
      console.log('got change:active on HistoricalLocation model')
      WebOfHistory.EventAggregator.trigger("historical_location:toggled", model)

  defaults:
    title: null
    shapefiles: []

  toggle: () ->
    return this.set('active', !this.isActive())

  isActive: () ->
    return this.get('active')

  label: () ->
    return this.get('name')

class WebOfHistory.Collections.HistoricalLocationsCollection extends Backbone.Collection
  model: WebOfHistory.Models.HistoricalLocation
  url: '/historical_locations'
