
class StockPredictor {
  constructor() {
      this.experts = [new Skittish,new Optimistic,new Random,new Bullish];
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
