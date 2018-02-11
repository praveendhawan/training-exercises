function FormValidator(myForm) {
  this.form = myForm.form;
  this.requiredElements = myForm.requiredElements;
  this.lengthRestricteditems = myForm.lengthRestricteditems;
  this.minimumRequiredLength = myForm.minimumRequiredLength;
  this.emailElements = myForm.emailElements;
  this.urlElements = myForm.urlElements;
  this.confirmNotificationItem = myForm.confirmNotificationItem;
}

FormValidator.prototype.bindEvents = function() {
  var _this = this;
  this.form.addEventListener("submit", function(e) { _this.toSubmit(e, this); });
};

FormValidator.prototype.toSubmit = function(event) {
  this.validStatus = true;
  this.isValid();
  this.confirmNotification(this.confirmNotificationItem);
  if(!this.validStatus) { event.preventDefault(); }
};

FormValidator.prototype.isValid = function() {
  this.validate(this.requiredElements, 'presence', 0);
  this.validate(this.lengthRestricteditems, 'lengthRestriction', this.minimumRequiredLength);
  this.validateEmailAndUrl(this.emailElements, EmailValidator);
  this.validateEmailAndUrl(this.urlElements, UrlValidator);
};

FormValidator.prototype.validate = function(elements, type, minimumLength) {
  for(var i = 0; i < elements.length; i++) {
    this.validStatus = this.validatePresenceAndLength(elements[i], type, minimumLength) && this.validStatus;
  }
};

FormValidator.prototype.validateEmailAndUrl = function(elements, elementConstructor) {
  for(var i = 0;i < elements.length; i++) {
    var element = new elementConstructor(elements[i].value),
      status = element.isValid(),
      message = this.errorMessage(elements[i], 'emailUrlValidation');
    this.validStatus = status && this.validStatus;
    this.showAlert(status, message);
  }
};

FormValidator.prototype.validatePresenceAndLength = function(element, type, minimumLength) {
  var status = element.value.length > minimumLength,
    message = this.errorMessage(element, type, minimumLength);
  this.showAlert(status, message);
  return status;
};

FormValidator.prototype.errorMessage = function(element, type, minimumLength) {
  if(type === 'presence') {
    var message = `${ element.name } cannot be empty.`;
  } else if (type === 'lengthRestriction') {
    message = `${ element.name } cannot be smaller than ${ this.minimumRequiredLength } characters.`;
  } else {
    message = `Please Enter a valid ${ element.name }`;
  }
  return message;
};

FormValidator.prototype.confirmNotification = function(checkbox) {
  if(checkbox.checked) {
    return (checkbox.checked = confirm("Are you sure about receiving notifications by email?"));
  }
};

FormValidator.prototype.showAlert = function(status, message) {
  if(!status) {
    alert(message);
  }
};