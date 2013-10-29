class WebOfHistory.Routers.ShapefilesRouter extends Backbone.Router
  initialize: (options) ->
    @shapefiles = new WebOfHistory.Collections.ShapefilesCollection()
    @shapefiles.reset options.shapefiles

  routes:
    "new"      : "newShapefile"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newShapefile: ->
    @view = new WebOfHistory.Views.Shapefiles.NewView(collection: @shapefiles)
    $("#shapefiles").html(@view.render().el)

  index: ->
    @view = new WebOfHistory.Views.Shapefiles.IndexView(shapefiles: @shapefiles)
    $("#shapefiles").html(@view.render().el)

  show: (id) ->
    shapefile = @shapefiles.get(id)

    @view = new WebOfHistory.Views.Shapefiles.ShowView(model: shapefile)
    $("#shapefiles").html(@view.render().el)

  edit: (id) ->
    shapefile = @shapefiles.get(id)

    @view = new WebOfHistory.Views.Shapefiles.EditView(model: shapefile)
    $("#shapefiles").html(@view.render().el)
