WebOfHistory.Views.HistoricalEventGroups ||= {}

class WebOfHistory.Views.HistoricalEventGroups.HistoricalEventGroupPanelView extends Backbone.Marionette.CompositeView
  template: JST["backbone/templates/event_groups/event_group_panel"]

  locations:
    "click .destroy" : "destroy"

  tagName: "div"
  className: "panel panel-default"

  itemView: WebOfHistory.Views.Shapefiles.ShapefileCheckboxView

  initialize: (options) ->
    this.options = options
    @model = this.options.model
    this.collection = @model.get('shapefiles')

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  appendHtml: (collectionView, itemView) ->
    collectionView.$("div#layers-panel-body-" + @model.id + " ul").append(itemView.el)

  render: () ->
    Backbone.Marionette.CompositeView.prototype.render.call(this)
    if this.collection.length == 0
      @$el.find(".collapse").collapse()
