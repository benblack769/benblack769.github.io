function zero_matrix(size){
    matrix = new Array(size)
    for(var i = 0; i < size; i++){
        matrix[i] = new Array(size)
        for(var j = 0; j < size; j++){
            matrix[i][j] = 0;
        }
    }
    return matrix
}
function random_color(){
    return 2*Math.floor(Math.random() * 2) - 1;
}
function rand_coloring(size){
    matrix = new Array(size)
    for(var i = 0; i < size; i++){
        matrix[i] = new Array(size)
        for(var j = 0; j < i; j++){
            matrix[i][j] = random_color();
            matrix[j][i] = matrix[i][j];
        }
        matrix[i][i] = 0;
    }
    return matrix
}
function list_all_k_sets_help(cur_idx,cur_set,cur_set_size,goal_size,total_size,run_fn){
    if(cur_set_size == goal_size){
        run_fn(cur_set)
    }
    else if(cur_idx == total_size){
        return;
    }
    else{
        list_all_k_sets_help(cur_idx+1,cur_set,cur_set_size,goal_size,total_size,run_fn)
        cur_set.push(cur_idx)
        list_all_k_sets_help(cur_idx+1,cur_set,cur_set_size+1,goal_size,total_size,run_fn)
        cur_set.pop()
    }
}
function list_all_k_sets(total_size,goal_size,run_fn){
    list_all_k_sets_help(0,[],0,goal_size,total_size,run_fn)
}
function count_all_k_sets(){
    //just a slow way of computing the binomial coefficient
    count = 0
    list_all_k_sets(70,6,function(val){
        count += 1
    })
    return count;
}
function max_edge(edge_weights,graph_size){
    var max_edge = [-1,-1]
    var max_weigth = 0;
    for(var i = 0; i < graph_size; i++){
        for(var j = 0; j < i; j++){
            var cur_weight = Math.abs(edge_weights[i][j])
            if(max_weigth < cur_weight){
                max_weigth = cur_weight
                max_edge = [i,j]
            }
        }
    }
    return max_edge
}
function largest_inclusive_edge(edges,graph_size,complete_size){
    edge_freq = zero_matrix(graph_size)
    var has_complete = false
    //counts number of K_r that edges actually complete
    list_all_k_sets(graph_size,complete_size,function(v_list){
        var first_elmt = edges[v_list[1]][v_list[0]]
        for(var i = 2; i < v_list.length; i++){
            for(var j = 0; j < i; j++){
                if(edges[v_list[i]][v_list[j]] != first_elmt){
                    return;
                }
            }
        }
        //var add_val = //*0.001;
        has_complete = true;
        for(var i = 0; i < v_list.length; i++){
            for(var j = 0; j < i; j++){
                edge_freq[v_list[i]][v_list[j]] += first_elmt * Math.random();
            }
        }
    })
    var my_max_edge = max_edge(edge_freq,graph_size)
    var has_edge = has_complete
    return {
        "has_edge": has_complete,
        "lower_bound": !has_complete,
        "edge":my_max_edge,
    }
}
function greedy_step(edges,graph_size,complete_size){
    var out_data = largest_inclusive_edge(edges,graph_size,complete_size)
    if(!out_data.has_edge){
        document.getElementById("output_display").innerHTML = out_data.lower_bound ? "Provable lower bound." : "Possible upper bound?";
        return true;
    }
    else{
        document.getElementById("output_display").innerHTML = "Evaluating...";
        var new_edge = out_data.edge;
        edges[new_edge[0]][new_edge[1]] = -edges[new_edge[0]][new_edge[1]];
        return false;
    }
}
function count_edges(edges,graph_size){
    var count = 0;
    for(var i = 0; i < graph_size; i++){
        for(var j = 0; j < i; j++){
            count += (edges[i][j]+1)/2;
        }
    }
    return count;
}
function max_edges(graph_size){
    return (graph_size*(graph_size-1))/2;
}
var cur_timer;
function greedy_execute(){
    if(cur_timer){
        window.clearInterval(cur_timer);
    }
    var graph_size = document.getElementById("graph_size").value;
    var complete_size = document.getElementById("clique_size").value;
    var edges = rand_coloring(graph_size)
    var milli_wait = 100;
    draw_graph(edges,graph_size)
    cur_timer = window.setInterval(function(){
        for(var c = 0; c < 10; c++){
            if(greedy_step(edges,graph_size,complete_size)){
                window.clearInterval(cur_timer);
                break;
            }
        }
        document.getElementById("num_display").innerHTML="Percentage of edges colored: "+ (count_edges(edges,graph_size)/max_edges(graph_size))
        draw_graph(edges,graph_size)
    }, milli_wait);
}
window.onload = function(){
    init_draw()
    greedy_execute()
}
