class WebOfHistory.Models.Shapefile extends Backbone.AssociatedModel
  paramRoot: 'shapefile'

  defaults:
    name: null
    description: null
    url: null

  initialize: () ->
    this.set('active', true)
    this.on "change:active", (model) ->
      WebOfHistory.EventAggregator.trigger("shapefile:toggled", model)

  toggle: () ->
    return this.set('active', !this.isActive())

  isActive: () ->
    return this.get('active')

  label: () ->
    return this.get('name')

class WebOfHistory.Collections.ShapefilesCollection extends Backbone.Collection
  model: WebOfHistory.Models.Shapefile
  url: '/shapefiles'
