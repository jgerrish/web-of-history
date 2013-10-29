WebOfHistory.Views.Shapefiles ||= {}

class WebOfHistory.Views.Shapefiles.IndexView extends Backbone.View
  template: JST["backbone/templates/shapefiles/index"]

  initialize: () ->
    @options.shapefiles.bind('reset', @addAll)

  addAll: () =>
    @options.shapefiles.each(@addOne)

  addOne: (shapefile) =>
    view = new WebOfHistory.Views.Shapefiles.ShapefileView({model : shapefile})
    @$("tbody").append(view.render().el)

  render: =>
    @$el.html(@template(shapefiles: @options.shapefiles.toJSON() ))
    @addAll()

    return this
