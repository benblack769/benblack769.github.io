var c;
var ctx;
function init_draw(){
    c = document.getElementById("myCanvas");
    ctx = c.getContext("2d");
}
function point_coords(graph_size,node_num){
    var radial_offset = (2*Math.PI*(node_num + 0.2))/graph_size;
    var radial_size = 100*Math.sqrt(Math.sqrt(graph_size));
    var height = radial_size+20;
    var xcen = radial_size+20;
    var pointcen = [xcen+radial_size*Math.cos(radial_offset),height+radial_size*Math.sin(radial_offset)];
    return pointcen
}
function draw_line(start,end,color){
    ctx.beginPath();
    ctx.moveTo(start[0],start[1]);
    ctx.lineTo(end[0],end[1]);
    if(color == 1){
        ctx.strokeStyle = 'red';
    }
    else if (color == -1){
        ctx.strokeStyle = 'blue';
    }
    else{
        ctx.strokeStyle = "rgba(0,0,0,0)";
    }
    ctx.stroke();
}
function draw_circ(cen){
    var rad = 10;
    ctx.beginPath();
    ctx.arc(cen[0],cen[1],rad,0,2*Math.PI);
    ctx.fill();
}
function draw_circles(graph_size){
    ctx.strokeStyle = 'black';
    for(var i = 0; i < graph_size; i++){
        draw_circ(point_coords(graph_size,i));
    }
}

function draw_edges(graph_size,coloring){
    for(var y = 0; y < graph_size; y++){
        for(var x = 0; x < y; x++){
            color = coloring[y][x]
            draw_line(point_coords(graph_size,x),point_coords(graph_size,y),color);
        }
    }
}
function draw_graph(coloring,graph_size){
    ctx.clearRect(0, 0, c.width, c.height);
    draw_circles(graph_size);
    draw_edges(graph_size,coloring);
}
