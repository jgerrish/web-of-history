WebOfHistory.Views.EmptyBox ||= {}

class WebOfHistory.Views.EmptyBox.CheckboxView extends Backbone.View
  template: JST["backbone/templates/emptybox/checkbox_item"]

  events:
    "click .destroy" : "destroy"
    "click .toggle"  : "toggle"

  tagName: "li"

  toggle: () ->
    console.log('toggle in CheckboxView')
    @model.toggle()

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  label: () ->
    @model.label()

  render: ->
    console.log('rendering CheckboxView')
    @$el.html(@template(@model.toJSON()))
    @$el.data("id", @model.id)
    @$el.find("input").prop('checked', @model.isActive());
    return this
