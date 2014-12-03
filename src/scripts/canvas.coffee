requestAnimationFrame = ->
  return requestAnimationFrame ||
         webkitRequestAnimationFrame ||
         mozRequestAnimationFrame ||
         (callback) ->
           setTimeout(callback, 1000 / 60)

canvas = document.createElement 'canvas'

c = canvas.getContext '2d'
r = 5
pie = Math.PI
pie2 = pie * 2
isMousedown = false

canvas.height = window.innerHeight - 50
canvas.width = window.innerWidth - 50

canvasPosition = canvas.getBoundingClientRect()

document.body.appendChild canvas

canvas.addEventListener 'mousemove', (e) ->
  c.clearRect(0, 0, canvas.width, canvas.height)
  drawPoint(e)
  if isMousedown
    c.restore()

canvas.addEventListener 'mousedown', (e) ->
  isMousedown = true
  drawPoint(e)
  c.save()

canvas.addEventListener 'mouseup', (e) ->
  isMousedown = false
  drawPoint(e)

drawPoint = (e) ->
  # requestAnimationFrame(drawPoint)
  x = e.offsetX - canvasPosition.left
  y = e.offsetY - canvasPosition.top
  c.beginPath()
  c.arc(x, y, r, 0, pie2)
  c.fillStyle = '#ffffff'
  c.fill()
