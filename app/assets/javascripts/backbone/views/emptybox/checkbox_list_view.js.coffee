WebOfHistory.Views.EmptyBox ||= {}

class WebOfHistory.Views.EmptyBox.CheckboxListView extends Backbone.View
  tagName: "ul"
  className: "checkbox-list"

  initialize: (options) ->
    @options = options
    @options.checkboxes.bind('reset', @addAll)
    @listid = @options.listid

  addAll: () =>
    @options.checkboxes.each(@addOne)

  addOne: (historicalLocation) =>
    view = new WebOfHistory.Views.EmptyBox.CheckboxView({model : historicalLocation})
    @$el.append(view.render().el)

  render: =>
    @addAll()

    return this
