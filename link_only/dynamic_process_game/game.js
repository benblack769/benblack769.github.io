var SQUARE_SIZE = 20;
var GAME_SIZE = 50;
var NUM_UNITS = 50;
var canvas;
var context;
var game;
function rgb(r, g, b){
    return "rgb("+r+","+g+","+b+")";
}
function start_game(){
    var stables = random_resource_stable_state();
    game = {
        resource_level: stables,
        stable_state: stables,
        units: init_units(),
    }
    return game;
}
function update_game(game){
    move_units(game.units)
    draw_game(game)
}
function init_canvas(){
    canvas = document.getElementById("myCanvas");
    context = canvas.getContext("2d");
}
function draw_game(game_state){
    context.clearRect(0, 0, canvas.width, canvas.height);
    draw_squares(game_state.resource_level);
    draw_units(game_state.units)
}
function run_game(){
    game = start_game()
    draw_game(game)
}
