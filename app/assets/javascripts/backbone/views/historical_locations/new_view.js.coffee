WebOfHistory.Views.HistoricalLocations ||= {}

class WebOfHistory.Views.HistoricalLocations.NewView extends Backbone.View
  template: JST["backbone/templates/historical_locations/new"]

  locations:
    "submit #new-historical_location": "save"

  constructor: (options) ->
    super(options)
    @model = new @collection.model()

    @model.bind("change:errors", () =>
      this.render()
    )

  save: (e) ->
    e.prlocationDefault()
    e.stopPropagation()

    @model.unset("errors")

    @collection.create(@model.toJSON(),
      success: (historical_location) =>
        @model = historical_location
        window.location.hash = "/#{@model.id}"

      error: (historical_location, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    @$el.html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
