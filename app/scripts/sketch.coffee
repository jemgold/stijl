# colors = ['#BF0000', '#000000', '#FFF700', '#E4F7F7', '#0500EF']
colors = ['#D3402E', '#282826', '#EDD53F', '#E4F7F7', '#194F99']

width = $(window).width()

Array::shuffle = -> @sort -> 0.5 - Math.random()

paper = Raphael(0, 0, width, 960);

class Box
  constructor: (@height, @width, @startX, @startY, @parent) ->
    @draw()

  draw: ->
    rect = paper.rect(@startX, @startY, @width, @height)
    rect.attr 'stroke-width', 0
    rect.attr 'fill', colors.shuffle()[0]

class Row
  constructor: (@height, @start) ->
    @draw()

  debug: ->
    rect = paper.rect(0, @start, paper.width, @height)
    # rect.attr 'fill', colors[0]
    rect.attr 'fill', colors.shuffle()[0]
    rect.attr 'opacity', 0.5
    rect.attr 'stroke-width', 1

  draw: ->
    for i in [0..paper.width] by @height
      new Box @height, @height, i, @start, @


heights = [40, 10, 20]
cheight = paper.height

drawy = ->
  paper.clear()
  rows = []
  start = 0
  for i in [1..20] #fuckkk thissssss
    height = heights.shuffle()[0]
    rows.push new Row height, start
    start += height

drawy()

$('body').mousemove ->
  drawy()