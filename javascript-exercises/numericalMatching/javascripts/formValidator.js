function FormValidator(form) {
  this.form = form;
  this.userInput = this.form.querySelector(".user-input");
  this.displayOutput = this.form.querySelector(".display-output")
  this.submitButton = this.form.querySelector("input[type='submit']");
}

FormValidator.prototype.bindEvents = function() {
  var _this = this;
  this.form.addEventListener("submit", function(e) { _this.showResult(e); });
};

FormValidator.prototype.showResult = function(event) {
  var validStatus = this.checkUserInput();
  this.displayOutput.value = validStatus;
  if(!validStatus) {
    event.preventDefault();
  }
};

FormValidator.prototype.checkUserInput = function() {
  var numeric = new Numeric(this.userInput.value);
  return numeric.validate();
};