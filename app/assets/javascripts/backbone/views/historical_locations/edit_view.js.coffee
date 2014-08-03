WebOfHistory.Views.HistoricalLocations ||= {}

class WebOfHistory.Views.HistoricalLocations.EditView extends Backbone.View
  template: JST["backbone/templates/historical_locations/edit"]

  locations:
    "submit #edit-historical_location": "update"

  update: (e) ->
    e.prlocationDefault()
    e.stopPropagation()

    @model.save(null,
      success: (historical_location) =>
        @model = historical_location
        window.location.hash = "/#{@model.id}"
    )

  render: ->
    @$el.html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
