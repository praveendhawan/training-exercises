function Question(min, max, operators) {
  this.min = min;
  this.max = max;
  this.operators = operators;
  this.firstOperand  = this.chooseNumber();
  this.secondOperand = this.chooseNumber();
  this.operator = this.chooseOperator();
  this.question = this.firstOperand + " " + this.operator + " " + this.secondOperand;
  this.evaluate(this.firstOperand, this.secondOperand, this.operator);
//move this to quiz  
}

Question.prototype.chooseOperator = function() {
  return this.operators[Math.floor(Math.random() * this.operators.length)];
};

Question.prototype.chooseNumber = function() {
  return Math.floor(Math.random() * (this.max - this.min) + this.min);
};

Question.prototype.evaluate = function(firstOperand, secondOperand, operator) {
  switch(operator) {
    case '-':
      this.actualResult = firstOperand - secondOperand;
      break;
    case '*':
      this.actualResult = firstOperand * secondOperand;
      break;
    case '/':
// roundup to 2 decimal
      this.actualResult = (firstOperand / secondOperand).toFixed(2);
      break;
    case '+':
       this.actualResult = firstOperand + secondOperand;
       break;
    default:
     this.actualResult = undefined;
  }
};
