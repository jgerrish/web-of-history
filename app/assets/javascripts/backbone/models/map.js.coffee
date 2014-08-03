class WebOfHistory.Models.Map extends Backbone.Model
  relations: [
    type: Backbone.Many
    key: 'shapefiles'
    relatedModel: 'WebOfHistory.Models.Shapefile'
    ,
  ]

  defaults:
    x_start: 51.505
    y_start: -0.09
