function User(displayElement) {
  "use strict";
  this.displayElement = displayElement;
}

User.prototype.init = function() {
  this.firstName = this.getAndValidateInput("first");
  this.lastName = this.getAndValidateInput("last");
  this.displayOutput();
};

User.prototype.getAndValidateInput = function(nameType) {
  var name = prompt("Enter your " + nameType + " name");
  if(this.isEmpty(name)) {
    this.showAlert();
    name = this.getAndValidateInput(nameType);
  }
  return name;
};

User.prototype.isEmpty = function (name) {
  return (name === null || !name.trim().length);
};

User.prototype.showAlert = function() {
  alert("Name cannot be empty");
};

User.prototype.displayOutput = function() {
  this.displayElement.innerHTML = "Hello " + this.firstName + " " + this.lastName;
};

window.onload = function() {
  var displayElement = document.getElementById("showName");
  var user = new User(displayElement);
  user.init();
};