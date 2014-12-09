canvas = document.querySelector('#canvas')
h = canvas.height = window.innerHeight
w = canvas.width = window.innerWidth

c = canvas.getContext('2d')

c.lineJoin = c.lineCap = 'round'
c.strokeStyle = 'rgb(255, 255, 255)'

PI2 = Math.PI * 2
r = 5
isDrawing = false
color =
  r: 255
  g: 255
  b: 255

points =
  a:
    x: 0
    y: 0
  b:
    x: 0
    y: 0

lineBase = 20

endDrawing = () ->
  isDrawing = false

canvas.addEventListener 'contextmenu', ((e) ->
  e.preventDefault()
), false

canvas.addEventListener 'mousedown', ((e) ->
  # left click
  if e.button == 2
    c.clearRect(0, 0, w, h)
  else if e.button == 0
    isDrawing = true
    points.a.x = points.b.x = e.clientX
    points.a.y = points.b.y = e.clientY
), false

canvas.addEventListener 'mousemove', ((e) ->
  return if !isDrawing
  points.a.x = points.b.x
  points.a.y = points.b.y
  points.b.x = e.clientX
  points.b.y = e.clientY

  # drawArc(e);
  drawLine();
), false

canvas.addEventListener 'mouseup', endDrawing
canvas.addEventListener 'mouseleave', endDrawing

drawLine = () ->
  l = calLineWidth(points.a, points.b)
  c.beginPath()
  c.moveTo(points.a.x, points.a.y)
  c.lineTo(points.b.x, points.b.y)
  c.lineWidth = l
  c.stroke()

calLineWidth = (p1, p2) ->
  d = Math.round(Math.sqrt(Math.pow(p1.x - p2.x, 2) + Math.pow(p1.y - p2.y, 2)))
  l = Math.round(lineBase - d / 10)
  if l <= 1
    l = 1
  return l

