WebOfHistory.Views.EmptyBox ||= {}

class WebOfHistory.Views.EmptyBox.PanelGroupView extends Backbone.Marionette.CollectionView
  #el: "#layers-accordion"

  itemView: WebOfHistory.Views.EmptyBox.PanelView

  initialize: (options) ->
    @options = options
    @collection = options.collection
    @options.collection.bind('reset', @addAll)
    #@options.historical_locations.bind('reset', @addAll)
