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
    var max_weigth = 0.2;
    for(var i = 0; i < graph_size; i++){
        for(var j = 0; j < i; j++){
            var cur_weight = edge_weights[i][j]
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
    //counts number of K_r that edges actually complete
    list_all_k_sets(graph_size,complete_size,function(v_list){
        for(var i = 0; i < v_list.length; i++){
            for(var j = 0; j < i; j++){
                if(edges[v_list[i]][v_list[j]] != 0){
                    return;
                }
            }
        }
        for(var i = 0; i < v_list.length; i++){
            for(var j = 0; j < i; j++){
                edge_freq[v_list[i]][v_list[j]] += 1
            }
        }
    })
    //clear out all the edges that will complete a K_r
    list_all_k_sets(graph_size,complete_size,function(v_list){
        var already_hit = false;
        var hit_edge = null
        for(var i = 0; i < v_list.length; i++){
            for(var j = 0; j < i; j++){
                if(edges[v_list[i]][v_list[j]] == 0){
                    if(already_hit){
                        return;
                    }
                    else{
                        already_hit = true;
                        hit_edge = [v_list[i],v_list[j]]
                    }
                }
            }
        }
        edge_freq[hit_edge[0]][hit_edge[1]] = 0;
    })
    return max_edge(edge_freq,graph_size)
}
function greedy_step(edges,graph_size,complete_size){
    var new_edge = largest_inclusive_edge(edges,graph_size,complete_size)
    if(new_edge[0] == -1){
        return true;
    }
    else{
        edges[new_edge[0]][new_edge[1]] = 1;
        return false;
    }
}
function count_edges(edges,graph_size){
    var count = 0;
    for(var i = 0; i < graph_size; i++){
        for(var j = 0; j < i; j++){
            count += edges[i][j];
        }
    }
    return count;
}
function max_edges(graph_size){
    return (graph_size*(graph_size-1))/2;
}
function greedy_execute(){
    var graph_size = 18;
    var complete_size = 4;
    var edges = zero_matrix(graph_size)
    var milli_wait = 100;
    draw_graph(edges,graph_size)
    var myVar = window.setInterval(function(){
        if(greedy_step(edges,graph_size,complete_size)){
            console.log("over")
            window.clearInterval(myVar);
        }
        document.getElementById("num_display").innerHTML= (count_edges(edges,graph_size)/max_edges(graph_size))
        draw_graph(edges,graph_size)
    }, milli_wait);
}
window.onload = function(){
    init_draw()
    greedy_execute()
}
