function Numeric(number) {
  this.number = number;
  this.NUMERIC_REGEX = /^[0-9]+$/;
}

Numeric.prototype.validate = function() {
  return this.NUMERIC_REGEX.test(this.number);
};