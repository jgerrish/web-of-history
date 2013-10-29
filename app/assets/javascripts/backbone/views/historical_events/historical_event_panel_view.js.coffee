WebOfHistory.Views.HistoricalEvents ||= {}

class WebOfHistory.Views.HistoricalEvents.HistoricalEventPanelView extends Backbone.Marionette.CompositeView
  template: JST["backbone/templates/historical_events/historical_event_panel"]

  events:
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
    console.log(itemView.el)
    console.log(collectionView.$("div#layers-panel-body-" + @model.id + " ul"))
    collectionView.$("div#layers-panel-body-" + @model.id + " ul").append(itemView.el)

  render: () ->
    console.log("render")
    Backbone.Marionette.CompositeView.prototype.render.call(this)
    if this.collection.length == 0
      @$el.find(".collapse").collapse()
