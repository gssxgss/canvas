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
    points['array'][points['size']] = {
      'x': e.offsetX - canvasPosition.left,
      'y': e.offsetY - canvasPosition.top,
      'w': input.value
    };
    drawPath(points)

canvas.addEventListener 'mouseup', () ->
  isDrawing = false


drawPath = (points) ->
  c.clearRect(0, 0, canvas.width, canvas.height)
  points['array'].forEach (value, index) ->
    console.log(value)
    if index % 2 == 0
      c.beginPath()
      c.moveTo(value.x, value.y)
    else
      c.lineTo(value.x, value.y)
      c.lineWidth = value.w
      c.strokeStyle = '#ffffff'
      c.stroke()
