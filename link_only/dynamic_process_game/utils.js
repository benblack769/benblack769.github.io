function add(vec1,vec2){
    return [vec1[0]+vec2[0],vec1[1]+vec2[1]]
}
function wrap_scalar(val){
    if(val < 0){
        return (val%GAME_SIZE) + GAME_SIZE
    }
    else if(val >= GAME_SIZE){
        return  (val%GAME_SIZE)
    }
    else{
        return val
    }
}
function wrap(vec){
    return [wrap_scalar(vec[0]),wrap_scalar(vec[1])]
}
