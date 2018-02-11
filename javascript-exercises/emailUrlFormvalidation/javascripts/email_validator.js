function EmailValidator(email) {
  this.email = email;
  this.EMAIL_VALIDATION_REGEX = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
}

EmailValidator.prototype.isValid = function() {
  return this.EMAIL_VALIDATION_REGEX.test(this.email);
};