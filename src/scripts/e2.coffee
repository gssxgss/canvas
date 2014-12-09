canvas = document.querySelector('#canvas')
c = canvas.getContext('2d')

h = canvas.height = window.innerHeight
w = canvas.width = window.innerWidth

c.lineJoin = c.lineCap = 'round'
c.shadowBlur = 1
c.shadowColor = 'rgba(255, 255, 255, 0.5)'
c.strokeStyle = 'rgb(255, 255, 255)'

isDrawing = false

color =
  r: 255
  g: 255
  b: 255

lineBase = 10
points = []

endDrawing = () ->
  isDrawing = false
  points = []

clearCanvas = () ->
  endDrawing()
  c.clearRect(0, 0, w, h)

canvas.addEventListener 'contextmenu', ((e) ->
  e.preventDefault()
), false

canvas.addEventListener 'mousedown', ((e) ->
  # left click
  if e.button == 2
    clearCanvas()
  else if e.button == 0
    isDrawing = true
    points.push
      x: e.clientX
      y: e.clientY
), false

canvas.addEventListener 'mousemove', ((e) ->
  return if !isDrawing
  points.push
    x: e.clientX
    y: e.clientY

  drawLine();
), false

canvas.addEventListener 'mouseup', endDrawing
canvas.addEventListener 'mouseleave', endDrawing

drawLine = () ->
  length = points.length + 1
  i = 1

  c.clearRect(0, 0, w, h)

  while i < length

    p1 = points[i - 1]
    p2 = points[i]
    mid1 = mid2
    mid2 = calcMidPoint(p1, p2) if p2
    w = calcLineWidth(p1, p2) if p2

    c.beginPath()
    if i == 1
      c.moveTo(p1.x, p1.y)
      c.lineTo(mid2.x, mid2.y)
    else if i == length
      c.moveTo(mid1.x, mid1.y)
      c.lineTo(p1.x, p1.y)
    else
      c.moveTo(mid1.x, mid1.y)
      c.quadraticCurveTo(p1.x, p1.y, mid2.x, mid2.y)

    c.lineWidth = w
    console.log(w)
    c.stroke()
    c.closePath()

    i++

calcDotDistance = (p1, p2) ->
  return Math.round(Math.sqrt(Math.pow(p1.x - p2.x, 2) + Math.pow(p1.y - p2.y, 2)))

calcLineWidth = (p1, p2) ->
  d = calcDotDistance(p1, p2)
  l = Math.round(lineBase - d / 10)
  if l <= 1
    l = 1
  return l

calcMidPoint = (p1, p2) ->
  return {
    x: (p1.x + p2.x) / 2
    y: (p1.y + p2.y) / 2
  }

###
generatePatchPoint = (p1, p2) ->
  d = calcDotDistance
  if d > 1
  while
###
