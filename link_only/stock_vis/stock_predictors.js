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
      this.update_val = parseFloat($("#bullish_discount").val())
      console.log( this.update_val)
  }
  guess() {
      return this.cur_val > 0 ? 1 : -1;
  }
  update(actual_value){
      this.cur_val *= (1-this.update_val);
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
class Negate{
    constructor(otherstrat){
        this.strategy = otherstrat
    }
    guess(){
        return - this.strategy.guess()
    }
    update(actual_value){
        this.strategy.update(actual_value)
    }
}

function Bull(){
    return new Bullish;
}
function Opti(){
    return new Optimistic;
}
function Skitti(){
    return new Skittish;
}
function Rand(){
    return new Random;
}

function BullNegate(){
    return new Negate(new Bullish);
}
function SkitNegate(){
    return new Negate(new Skittish);
}
function Pessimistic(){
    return new Negate(new Optimistic);
}

var all_strat_info = [Bull,Opti,Skitti,Rand,BullNegate,SkitNegate,Pessimistic]
