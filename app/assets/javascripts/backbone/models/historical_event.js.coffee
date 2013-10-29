class WebOfHistory.Models.HistoricalEvent extends Backbone.AssociatedModel
  paramRoot: 'historical_event'

  relations: [
      type: Backbone.Many
      key: 'shapefiles'
      relatedModel: 'WebOfHistory.Models.Shapefile'
    ,
  ]

  initialize: () ->
    this.set('active', true)
    this.on "change:active", (model) ->
      WebOfHistory.EventAggregator.trigger("historical_event:toggled", model)

  defaults:
    title: null
    shapefiles: []

  toggle: () ->
    return this.set('active', !this.isActive())

  isActive: () ->
    return this.get('active')

  label: () ->
    return this.get('title')

class WebOfHistory.Collections.HistoricalEventsCollection extends Backbone.Collection
  model: WebOfHistory.Models.HistoricalEvent
  url: '/historical_events'
