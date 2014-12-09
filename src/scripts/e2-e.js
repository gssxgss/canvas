var xStart,
xEnd,
yStart,
yEnd,
paint,
ctx;
$(document).ready(function (){

  if (typeof FlashCanvas != "undefined") {
    FlashCanvas.initElement($('canvas')[0]);
  }
  ctx = $('canvas')[0].getContext("2d");
  ctx.strokeStyle = '#000';
  ctx.lineJoin="round";
  ctx.lineCap="round";
  ctx.lineWidth = 1;


  $('canvas').bind('mousedown mousemove mouseup mouseleave', function(e){
    var orig = e.originalEvent;

    if(e.type == 'mousedown'){
      e.preventDefault(); e.stopPropagation();

      xStart = e.clientX - $(this).offset().left;
      yStart = e.clientY - $(this).offset().top;
      xEnd = xStart;
      yEnd = yStart;

      paint = true;
      draw(e.type);

    }else if(e.type == 'mousemove'){
      if(paint==true){
        xEnd = e.clientX - $(this).offset().left;
        yEnd = e.clientY - $(this).offset().top;


        // lineThickness = 5 - Math.sqrt((xStart - xEnd) *(xStart-xEnd) + (yStart - yEnd) * (yStart-yEnd))/10;
        // if(lineThickness < 1){
        //     lineThickness = 1;   
        // }

        lineThickness = 1 + Math.sqrt((xStart - xEnd) *(xStart-xEnd) + (yStart - yEnd) * (yStart-yEnd))/5;



        if(lineThickness > 10){
          lineThickness = 10;   
        }

        ctx.lineWidth = lineThickness;
        draw(e.type);
      }
    }else if(e.type == 'mouseup'){
      paint = false;
    }else if(e.type == 'mouseleave'){
      paint = false;
    }
  });
});


function draw(event){

  if(event == 'mousedown'){
    ctx.beginPath();
    ctx.moveTo(xStart, yStart);
    ctx.lineTo(xEnd, yEnd);
    ctx.stroke();
  }else if(event == 'mousemove'){
    ctx.beginPath();
    ctx.moveTo(xStart, yStart);
    ctx.lineTo(xEnd, yEnd);
    ctx.stroke();
  }
  xStart = xEnd;
  yStart = yEnd;                     
}
