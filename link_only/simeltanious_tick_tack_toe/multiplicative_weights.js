function sum(vals){
    var sum = 0;
    for(var i = 0; i < vals.length; i++){
        sum += vals[i];
    }
    return sum;
}
function max(vals){
    var max = -10e10;
    for(var i = 0; i < vals.length; i++){
        max = Math.max(max,vals[i]);
    }
    return max;
}
function normalize(vals){
    var max_weight = max(vals);
    if(max_weight == 0){
        return vals;
    }
    for(var i = 0; i < vals.length; i++){
        vals[i] /= max_weight;
    }
    return vals;
}
class MultiplicativeWeights {
  constructor(num_weights,multiplicative_weight_update_val) {
      this.weights = new Array(num_weights);
      this.weights.fill(1);
      this.update_constant = multiplicative_weight_update_val;
  }
  guess(advice){
      var picked_advisor = random_index(this.weights);
      return advice[picked_advisor];
  }
  update(advice, actual){
      for(var i = 0; i < this.weights.length; i++){
          if(advice[i] != actual){
              this.weights[i] *= (1 - this.update_constant);
              console.assert(this.weights[i] > 0,"numbers not stable")
          }
      }
      normalize(this.weights);
  }
}
