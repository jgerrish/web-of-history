WebOfHistory.Views.HistoricalEvents ||= {}

class WebOfHistory.Views.HistoricalEvents.HistoricalEventCheckboxView extends Backbone.View
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

  label: () ->
    @model.label()

  render: ->
    @$el.html(@template(@model.toJSON()))
    @$el.data("id", @model.id)
    @$el.find("input").prop('checked', @model.isActive());
    return this
