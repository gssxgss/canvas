window.requestAnimationFrame = window.requestAnimationFrame ||
                               window.webkitRequestAnimationFrame ||
                               window.mozRequestAnimationFrame

window.cancelAnimationFrame = window.cancelAnimationFrame ||
                              window.webkitCancelAnimationFrame ||
                              window.mozCancelAnimationFrame

vw = window.innerWidth
vh = window.innerHeight
canvas = document.querySelector('#canvas')
ctx = canvas.getContext('2d')

PI2 = 2 * Math.PI

initCanvas = ->
  canvas.width = vw
  canvas.height = vh

initCanvas()

class Wave
  constructor: ->

    @waves = []
    @w = vw
    @h = vh
    @d = 30
    @n = 0

  new: (center) ->
    x = center.offsetX
    y = center.offsetY
    c = if @n is 0 then '#ff1493' else '#1E90FF'
    r = 0
    @n = if @n is 0 then 1 else 0

    rmax = Math.ceil(@calcMaxDistance(x, y) / @d) * @d

    point =
      x: x
      y: y
      c: c
      r: r
      rmax: rmax

    @waves[@n] = point


  drawArc: (x, y, r, c) ->
    ctx.beginPath()
    ctx.arc(x, y, r, 0, PI2)
    ctx.strokeStyle = c
    ctx.lineWidth = 2
    ctx.stroke()
    ctx.closePath()

  drawWave: =>
    @waves.forEach (circle) =>

      r = circle.r
      while r > 0
        @drawArc(circle.x, circle.y, r, circle.c)
        r -= @d

      circle.r += 2

      if circle.r > circle.rmax
        circle.r -= @d

  calcMaxDistance: (x, y) ->
    xmax = if x < @w / 2 then @w else 0
    ymax = if y < @h / 2 then @h else 0
    return Math.ceil(Math.sqrt(Math.pow(xmax - x, 2) + Math.pow(ymax - y, 2)))

  render: =>
    ctx.clearRect(0, 0, @w, @h)
    @drawWave()
    window.requestAnimationFrame(@render)


wave = new Wave()
wave.render()

canvas.addEventListener 'click', (e) =>
  wave.new(e)
