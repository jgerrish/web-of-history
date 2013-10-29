WebOfHistory.Views.Shapefiles ||= {}

class WebOfHistory.Views.Shapefiles.EditView extends Backbone.View
  template: JST["backbone/templates/shapefiles/edit"]

  events:
    "submit #edit-shapefile": "update"

  update: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success: (shapefile) =>
        @model = shapefile
        window.location.hash = "/#{@model.id}"
    )

  render: ->
    @$el.html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
