WebOfHistory.Views.Shapefiles ||= {}

class WebOfHistory.Views.Shapefiles.ShapefileView extends Backbone.View
  template: JST["backbone/templates/shapefiles/shapefile"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    @$el.html(@template(@model.toJSON() ))
    return this
