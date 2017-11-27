
class StockPredictor {
  constructor() {
      var mul_weights_val = all_strat_info.mul_weights
      delete all_strat_info.mul_weights
      this.experts = Object.values(all_strat_info).map(function(data){return data.strat_const()})
      all_strat_info["mul_weights"] = mul_weights_val
      var mul_weights_update_val = parseFloat($("#mul_weights_constant").val())
      this.mul_weights = new MultiplicativeWeights(this.experts.length,mul_weights_update_val);
  }
  get_advice(){
      return this.experts.map(function(expert){return expert.guess()})
  }
  guess(){
      this.current_advice = this.get_advice()
      return this.mul_weights.guess(this.current_advice)
  }
  update(actual){
      this.mul_weights.update(this.current_advice,actual)
      this.experts.forEach(function(expert){
          expert.update(actual)
      })
  }
}
function PredStocks(){
    return new StockPredictor;
}
