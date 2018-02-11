window.onload = function() {
  var _form = document.getElementsByClassName("myform")[0];
  var myForm = {
    form : _form,
    requiredElements : _form.querySelectorAll(".validate_presence"),
    lengthRestricteditems : _form.querySelectorAll(".validate_minimum_length"),
    minimumRequiredLength : 50,
    confirmNotificationItem : _form.querySelector("#notification"),
    emailElements : _form.querySelectorAll(".validate-pattern-email"),
    urlElements : _form.querySelectorAll(".validate-pattern-url"),
    confirmNotificationItem : _form.querySelector("#notification")
  };
  var myFormValidator = new FormValidator(myForm);
  myFormValidator.bindEvents();
};