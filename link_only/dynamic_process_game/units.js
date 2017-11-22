
function init_units(){
    unit1 = {
        location: [3,5],
    }
    unit2 = {
        location: [10,4],
    }
    return [unit1,unit2]
}
function draw_circ(cen,color){
    var rad = SQUARE_SIZE / 3.5;
    context.beginPath();
    context.arc((cen[0]+0.5)*SQUARE_SIZE,(cen[1]+0.5)*SQUARE_SIZE,rad,0,2*Math.PI);
    context.fillStyle = color;
    context.fill();
}
function draw_units(units){
    units.forEach(function(unit){
        draw_circ(unit.location,"red")
    })
}
function random_move(){
    var move = Math.floor(Math.random()*4);
    var sign = (move % 2)*2-1;
    if(move > 2){
        return [sign,0]
    } else {
        return [0,sign]
    }
    return [move >> 1,move & 1]
}
function move_units(units){
    units.forEach(function(unit){
        unit.location = wrap(add(unit.location,random_move()))
    })
}
