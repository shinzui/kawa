window.Kawa ?= {}

class Kawa.TagManager

  constructor: (tags) ->
    @tags = tags
    @width = 960
    @height = 600
    @setupCloud()

  setupCloud: ->
    d3.layout.cloud().size([@width,@height])
      .words(@tags.map((d)-> {text: d.name, size: d.weight}))
      .rotate(-> ~~(Math.random() * 2 * 90))
      .fontSize((d)->  d3.scale.linear(_.uniq(_.pluck(@tags, "size"))).range([10..38])(d.size))
      .on("end", @draw)
      .start()

  draw: (words)=>
    d3.select("div#cloud-view").append("svg")
      .attr("width", @width)
      .attr("height", @height)
      .append("g")
      .attr("transform", "translate(#{@width/2},#{@height/2})")
      .selectAll("text")
      .data(words)
      .enter().append("text")
      .style("font-size", (d) -> "#{d.size}px")
      .style("fill", (d) -> d3.scale.category20c().domain(_.pluck(words, "text"))(d.text))
      .attr("text-anchor", "middle")
      .attr("transform", (d) -> "translate(#{[d.x,d.y]})rotate(#{d.rotate})")
      .on("click", (e)-> window.location = Routes.pages_path({tag: e.text}))
      .text((d) -> d.text)
