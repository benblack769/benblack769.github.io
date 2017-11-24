class Optimistic {
  constructor() {
  }
  guess() {
      return 1;
  }
  update(actual_value){

  }
}
function random_sign(){
    return Math.floor(Math.random()*2)*2-1;
}
class Random {
  constructor() {
  }
  guess() {
      return random_sign();
  }
  update(actual_value){
  }
}
class Bullish {
  constructor() {
      this.cur_val = 0;
  }
  guess() {
      return this.cur_val > 0 ? 1 : -1;
  }
  update(actual_value){
      this.cur_val *= 0.01;
      this.cur_val += actual_value;
  }
}
class Skittish {
  constructor() {
      this.prev_sign = 1;
  }
  guess() {
      return this.prev_sign;
  }
  update(actual_value){
      this.prev_sign = actual_value > 0 ? 1 : -1;
  }
}
var strategy_constructors = [Skittish,Optimistic,Random,Bullish];
