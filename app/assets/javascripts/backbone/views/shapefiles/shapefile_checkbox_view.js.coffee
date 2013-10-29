WebOfHistory.Views.Shapefiles ||= {}

class WebOfHistory.Views.Shapefiles.ShapefileCheckboxView extends Backbone.Marionette.ItemView
  template: JST["backbone/templates/historical_events/checkbox_item"]

  events:
    "click .destroy" : "destroy"
    "click .toggle"  : "toggle"

  tagName: "li"

  toggle: () ->
    @model.toggle()

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  label: ->
    return @model.label()

  render: ->
    console.log "render in ShapefileCheckboxView called"
    @$el.html(@template(@model.toJSON()))
    @$el.data("id", @model.id)
    @$el.find("input").prop('checked', @model.isActive());
    return this
