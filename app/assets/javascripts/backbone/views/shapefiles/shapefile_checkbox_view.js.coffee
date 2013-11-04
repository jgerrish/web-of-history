WebOfHistory.Views.Shapefiles ||= {}

class WebOfHistory.Views.Shapefiles.ShapefileCheckboxView extends Backbone.Marionette.ItemView
  template: JST["backbone/templates/shapefiles/shapefile_checkbox_item"]

  events:
    "click .destroy" : "destroy"
    "click .toggle"  : "toggle"

  tagName: "li"

  initialize: (options) ->
    this.options = options
    @model = this.options.model

  toggle: (event) ->
    event.stopPropagation()
    @model.toggle()

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  label: ->
    return @model.label()

  render: ->
    @$el.html(@template(@model.toJSON()))
    @$el.data("id", @model.id)
    checkbox = @$el.find("input")
    checkbox.prop('checked', @model.isActive())
    return this
