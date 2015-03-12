window.requestAnimationFrame = window.requestAnimationFrame ||
                               window.webkitRequestAnimationFrame ||
                               window.mozRequestAnimationFrame

window.cancelAnimationFrame = window.cancelAnimationFrame ||
                              window.webkitCancelAnimationFrame ||
                              window.mozCancelAnimationFrame

PI2 = 2 * Math.PI
canvas = document.querySelector("#canvas")
ctx = canvas.getContext("2d")
isPlaying = false
theme = null

setSize = () ->
  canvas.width = window.innerWidth
  canvas.height = window.innerHeight

setSize()

window.addEventListener "resize", setSize


class Drops
  constructor: ->
    @audio = document.querySelector('#audio')
    @duration = @audio.duration

    @points = []
    @theme =
      "vivid": [
        [84,146,219]
        [251,254,164]
        [207,252,236]
        [180,243,253]
        [106,207,225]
      ]
      "forest": [
        [83,159,162]
        [114,177,164]
        [171,204,177]
        [196,219,180]
        [212,226,182]
      ]
      "spring": [
        [244,252,232]
        [195,255,104]
        [135,214,155]
        [78,150,137]
        [126,208,214]
      ]
      "summer": [
        [204,243,255]
        [143,229,255]
        [87,216,255]
        [41,205,255]
        [243,134,48]
      ]
      "autumn": [
        [128,188,163]
        [246,247,189]
        [230,172,39]
        [191,77,40]
        [101,86,67]
      ]
      "winter": [
        [139,166,172]
        [215,215,184]
        [229,230,201]
        [248,248,236]
        [189,205,208]
      ]

    @colors = @theme["spring"]
    @bar =
      x: 0
      y: canvas.height / 2
      h: 4
      c: "#fff"

  randomPoint: =>
    p =
      x: ~~(Math.random() * canvas.width)
      y: ~~(Math.random() * canvas.height)
      r: 1
      o: 1
      d: ~~(Math.random() * 3 + 1)
      c: @colors[~~(Math.random() * 5)]
    return p

  generatePoints: =>
    @points.push @randomPoint()

  drawCircle: (point) ->
    ctx.beginPath()
    ctx.arc(point.x, point.y, point.r, 0, PI2, false)
    ctx.fillStyle = "rgba(#{point.c[0]}, #{point.c[1]}, #{point.c[2]}, #{point.o})"
    ctx.strokeStyle = "rgba(255, 255, 255, 0.5)"
    ctx.lineWidth = 1
    ctx.fill()
    ctx.stroke()
    ctx.closePath()

  drawDrops: =>
    @points.forEach (point, i) =>
      if point.o > 0
        @drawCircle(point)
        point.o -= 0.01
        point.r += point.d
      else
        @points.shift()

  stop: =>
    window.cancelAnimationFrame(@call)

  play: =>
    v = 0
    @audio.volume = v
    @audio.play()
    interval = window.setInterval () ->
      v += 1
      @audio.volume = v / 10
      if v == 10
        window.clearInterval(interval)
    ,100

  pause: =>
    v = 10
    interval = window.setInterval () ->
      v-=1
      if v == 0
        window.clearInterval(interval)
        @audio.pause()
        window.cancelAnimationFrame(@call)
      else
        @audio.volume = v / 10
    ,100

  updateState: =>
    w = ~~(@audio.currentTime / @audio.duration * canvas.width)
    ctx.fillStyle = @bar.c
    ctx.fillRect(@bar.x, @bar.y, w, @bar.h)

  render: =>
    ctx.clearRect(0, 0, canvas.width, canvas.height)
    ctx.globalCompositeOperation = "overlay"
    @generatePoints() if isPlaying
    @drawDrops()
    @updateState()
    if @points.length == 0
      @stop()
    @call = window.requestAnimationFrame(@render)

rainDrops = new Drops

document.body.addEventListener "click", () ->
  if isPlaying
    rainDrops.pause()
    isPlaying = false
  else
    rainDrops.render()
    rainDrops.play()
    isPlaying = true

nav = document.querySelector('#nav')
nav.addEventListener "click", (e) ->
  e.stopPropagation()
  if !!e.target.getAttribute('for')
    theme = e.target.getAttribute('for')
  rainDrops.colors = rainDrops.theme[theme]
