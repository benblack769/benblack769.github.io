
function draw_square(point,color){
    context.beginPath();
    context.fillStyle = color;
    context.fillRect(point[0], point[1], SQUARE_SIZE, SQUARE_SIZE);
}
function resource_color(level){
    return rgb(0,Math.floor(255*level),0)
}
function draw_squares(resource_level){
    for(var y = 0; y < GAME_SIZE; y++){
        for(var x = 0; x < GAME_SIZE; x++){
            draw_square([x*SQUARE_SIZE,y*SQUARE_SIZE],resource_color(resource_level[y][x]))
        }
    }
}
function update_resource_level(rc_level,rc_stable){
    for(var y = 0; y < GAME_SIZE; y++){
        for(var x = 0; x < GAME_SIZE; x++){
            var cap = rc_stable[y][x];
            var old_level = rc_level[y][x];
            var mul_v = 0.1;
            var new_level =  old_level + mul_v*old_level - mul_v*old_level*old_level/cap;
            rc_level[y][x] = new_level;
        }
    }
}
function random_resource_stable_state(){
    var res = new Array(GAME_SIZE);
    for(var y = 0; y < GAME_SIZE; y++){
        res[y] = new Array(GAME_SIZE);
        for(var x = 0; x < GAME_SIZE; x++){
            res[y][x] = Math.random();
        }
    }
    return res;
}
