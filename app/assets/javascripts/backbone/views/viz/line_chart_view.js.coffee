WebOfHistory.Views.Viz ||= {}

class WebOfHistory.Views.Viz.LineChartView extends Backbone.View

  initialize: (options) ->
    @options = options
    if @options and @options.map_el
      @map_el = @options.map_el
    if @options and @options.data
      @data = @options.data

  draw: ->
    console.log 'drawing chart'
    id = this.$el.attr('id')
    console.log(id)

    margin =
      top: 10
      right: 10
      bottom: 20
      left: 30

    width = 200 - margin.left - margin.right
    height = 150 - margin.top - margin.bottom
    parseDate = d3.time.format("%d-%b-%y").parse
    x = d3.time.scale().range([
      0
      width
    ])
    y = d3.scale.linear().range([
      height
      0
    ])
    xAxis = d3.svg.axis().scale(x).orient("bottom")
    yAxis = d3.svg.axis().scale(y).orient("left")
    line = d3.svg.line().x((d) ->
      x d.date
    ).y((d) ->
      y d.close
    )
    console.log(@map_el[0])
    svg = d3.select(this.el).append("svg").attr("width", width + margin.left + margin.right).attr("height", height + margin.top + margin.bottom).append("g").attr("transform", "translate(" + margin.left + "," + margin.top + ")")
    d3.tsv "/data.tsv", (error, data) ->
      data.forEach (d) ->
        d.date = parseDate(d.date)
        d.close = +d.close
        return

      x.domain d3.extent(data, (d) ->
        d.date
      )
      y.domain d3.extent(data, (d) ->
        d.close
      )

      svg.append("g").attr("class", "x axis").attr("transform", "translate(0," + height + ")").call(xAxis)
      svg.append("g").attr("class", "y axis").call(yAxis).append("text").attr("transform", "rotate(-90)").attr("y", 6).attr("dy", ".71em").style("text-anchor", "end").text("Price ($)")
      svg.append("path").datum(data).attr("class", "line").attr("d", line)
      return

  render: ->
    console.log 'rendering chart'
    this.draw()
    return this
