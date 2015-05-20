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

PI = Math.PI
PI2 = 2 * PI

initCanvas = ->
  canvas.width = vw
  canvas.height = vh

initCanvas()

colors = [
  '#1ABC9C'
  '#2ECC71'
  '#3498DB'
  '#9B59B6'
  '#34495E'
  '#F1C40F'
  '#E67E22'
  '#E74C3C'
  '#ECF0F1'
  '#95A5A6'
]

class Ball
  constructor: ->
    r = ~~(Math.random() * 20) + 20
    range =
      x: vw - 2 * r
      y: vh - 2 * r
    x = ~~(Math.random() * range.x)
    y = ~~(Math.random() * range.y)
    c = colors[~~(Math.random() * colors.length)]
    vx = 2 * ~~(Math.random() * 5)
    vy = 2 * ~~(Math.random() * 5)
    console.log x, y, r, c, vx, vy

ball = new Ball

