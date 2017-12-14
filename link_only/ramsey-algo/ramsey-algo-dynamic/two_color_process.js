
function random_color(){
    return 2*Math.floor(Math.random() * 2) - 1;
}
function copy_2d_array(vals,size){
    copy = new Array(size)
    for(var i = 0; i < size; i++){
        copy[i] = vals[i].slice(0)
    }
    return copy
}
function update_vals(cur_vals, edges, size){
    new_vals = copy_2d_array(cur_vals,size)
    for(var i = 0; i < size; i++){
        for(var j = 0; j < size; j++){
            if(j == i){
                continue;
            }
            if(edges[i][j] == 1){
                for(var k = 0; k < size; k++){
                    var cv = cur_vals[j][k];
                    if(cv > 0){
                        new_vals[i][k] += cv;
                    }
                }
            }
            else if(edges[i][j] == -1){
                for(var k = 0; k < size; k++){
                    var cv = cur_vals[j][k];
                    if(cv < 0){
                        new_vals[i][k] += cv;
                    }
                }
            }
            else{
                console.log("bad edge");
            }
        }
    }
    return new_vals
}
function greatest_mag_edge(vals,size){
    var max_mag = -1;
    var max_edge = [0,0]
    for(var i = 0; i < size; i++){
        for(var j = 0; j < size; j++){
            if(j == i){
                continue;
            }
            var mag = Math.abs(vals[i][j]);
            if(mag > max_mag){
                max_mag = mag
                max_edge = [i,j]
            }
        }
    }
    return max_edge
}
function change_edge(edges, edge){
    console.log(edge)
    var x = edge[0]
    var y = edge[1]
    if(edges[x][y] != edges[y][x]){
        console.log("something is wrong!")
    }
    var old_weight = edges[x][y];
    edges[x][y] = -old_weight
    edges[y][x] = -old_weight
}
function find_best_flip_edge(edges,size){
    var start_vals = copy_2d_array(edges,size)
    console.log(start_vals)
    for(var i = 0; i < 4; i++){
        start_vals = update_vals(start_vals,edges,size)
        console.log(start_vals)
    }
    return greatest_mag_edge(start_vals,size)
}
function update_graph(edges,size){
    var edge = find_best_flip_edge(edges,size)
    change_edge(edges,edge)
    draw_graph(edges,size)
}
function draw_new_graph(){
    update_graph(coloring, my_size)
}
window.onload = function(){
    init_draw()
    var my_size = 17;
    var coloring = rand_coloring(my_size)
    draw_graph(coloring,my_size)
}
