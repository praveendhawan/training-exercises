function FormValidation(inputArguments) {
  this.form = inputArguments.form;
  this.requiredElements = inputArguments.requiredElements;
  this.lengthRestricteditems = inputArguments.lengthRestricteditems;
  this.confirmNotificationItem = inputArguments.confirmNotificationItem;
  this.minimumRequiredLength = inputArguments.minimumRequiredLength;
}

FormValidation.prototype.bindEvents = function() {
  var _this = this;
  this.form.addEventListener("submit", function(e){ _this.validateForSubmission(e, this); });
};

FormValidation.prototype.validateForSubmission = function(event) {
  this.validStatus = true;
  this.isValid();
  this.confirmNotification(this.confirmNotificationItem);
  if(!this.validStatus) {
    event.preventDefault();
  }
};

FormValidation.prototype.isValid = function() {
  this.checkAllFieldsPresence();
  this.checkAllFieldsMinimumLength();
};

FormValidation.prototype.checkAllFieldsPresence = function() {
  for(var i = 0; i < this.requiredElements.length; i++) {
    this.validStatus = this.validateFieldPresence(this.requiredElements[i]) && this.validStatus;
   }
};

FormValidation.prototype.checkAllFieldsMinimumLength = function() {
  for(i = 0; i < this.lengthRestricteditems.length; i++) {
    this.validStatus = this.validateFieldLength(this.lengthRestricteditems[i],
                         this.minimumRequiredLength) && this.validStatus;
  }
};

FormValidation.prototype.validateFieldPresence = function(field) {
  var status = field.value.length;
  if(!status) {
    alert(`${ field.name } cannot be empty.`);
  }
  return !!(status);
};

FormValidation.prototype.validateFieldLength = function(field, minimumLength) {
  var status = field.value.length > 0 && field.value.length < minimumLength;
  if(status) {
    alert(`${ field.name } cannot be smaller than ${ minimumLength } characters.`);
  }
  return !status;
};

FormValidation.prototype.confirmNotification = function(checkbox) {
  if(checkbox.checked) {
    return (checkbox.checked = confirm("Are you sure about receiving notifications by email?"));
  }
};

window.onload = function() {
  var _form = document.getElementsByClassName("myform")[0];
  var inputArguments = {
    form : _form,
    requiredElements : _form.querySelectorAll(".validate_presence"),
    lengthRestricteditems : _form.querySelectorAll(".validate_minimum_length"),
    minimumRequiredLength : 50,
    confirmNotificationItem : _form.querySelector("#notification")
  };
  var myFormValidator = new FormValidation(inputArguments);
  myFormValidator.bindEvents();
};