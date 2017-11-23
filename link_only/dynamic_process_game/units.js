function random_unit(){
    return {
        location: random_point(),
        pick_up_proportion: Math.random(),
        keep_moving_weight: Math.random(),
    }
}
function init_units(){
    var res = new Array(NUM_UNITS)
    for(var i = 0; i < NUM_UNITS; i++){
        res[i] = random_unit()
    }
    return res
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
    var move = random_int(4);
    var sign = (move % 2)*2-1;
    if(move > 2){
        return [sign,0]
    } else {
        return [0,sign]
    }
}
function move_units(units){
    units.forEach(function(unit){
        unit.location = wrap(add(unit.location,random_move()))
    })
}
