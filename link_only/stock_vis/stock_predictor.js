
var MUL_WEIGHTS_UPDATE = 0.1;
class StockPredictor {
  constructor() {
      this.experts = [new Skittish,new Optimistic,new Random,new Bullish];
      this.mul_weights = new MultiplicativeWeights(this.experts.length,MUL_WEIGHTS_UPDATE);
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
