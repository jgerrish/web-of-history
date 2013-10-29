WebOfHistory.Views.Shapefiles ||= {}

class WebOfHistory.Views.Shapefiles.NewView extends Backbone.View
  template: JST["backbone/templates/shapefiles/new"]

  events:
    "submit #new-shapefile": "save"

  constructor: (options) ->
    super(options)
    @model = new @collection.model()

    @model.bind("change:errors", () =>
      this.render()
    )

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")

    @collection.create(@model.toJSON(),
      success: (shapefile) =>
        @model = shapefile
        window.location.hash = "/#{@model.id}"

      error: (shapefile, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    @$el.html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
