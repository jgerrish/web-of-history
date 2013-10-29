WebOfHistory.Views.Shapefiles ||= {}

class WebOfHistory.Views.Shapefiles.ShowView extends Backbone.View
  template: JST["backbone/templates/shapefiles/show"]

  render: ->
    @$el.html(@template(@model.toJSON() ))
    return this
