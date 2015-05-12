requestAnimationFrame = ->
  return requestAnimationFrame ||
         webkitRequestAnimationFrame ||
         mozRequestAnimationFrame ||
         (callback) ->
           setTimeout(callback, 1000 / 60)

canvas = document.createElement 'canvas'
input = document.querySelector('#width')

c = canvas.getContext '2d'
w = input.value
isDrawing = false
isMoving = false
points = {
  'array': [],
  'size': 0
}

canvas.height = window.innerHeight - 100
canvas.width = window.innerWidth - 100

canvasPosition = canvas.getBoundingClientRect()

document.body.appendChild canvas

canvas.addEventListener 'mousedown', (e) ->
  points['array'].push({
    'x': e.offsetX - canvasPosition.left,
    'y': e.offsetY - canvasPosition.top
  });
  points['size'] = points['array'].length
  isDrawing = true

canvas.addEventListener 'mousemove', (e) ->
  if isDrawing
    isMoving = true
    points['array'][points['size']] = {
      'x': e.offsetX - canvasPosition.left,
      'y': e.offsetY - canvasPosition.top,
      'w': input.value
    };
    drawPath(points)

canvas.addEventListener 'mouseup', (e) ->
  isDrawing = false
  if isMoving
    isMoving = false
  else
    points['array'].pop()


drawPath = (points) ->
  c.clearRect(0, 0, canvas.width, canvas.height)
  points['array'].forEach (value, index) ->
    if index % 2 == 0
      c.beginPath()
      c.lineCap = 'round'
      c.moveTo(value.x, value.y)
    else
      c.lineTo(value.x, value.y)
      c.lineWidth = value.w
      c.strokeStyle = '#ffffff'
      c.stroke()
