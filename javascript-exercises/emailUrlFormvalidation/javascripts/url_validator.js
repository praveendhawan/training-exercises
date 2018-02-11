function UrlValidator (url) {
  this.url = url;
  this.URL_VALIDATION_REGEX = /^(http[s]?:\/\/){0,1}(www\.){0,1}[a-zA-Z0-9\.\-]+\.[a-zA-Z]{2,5}[\.]{0,1}/;
}

UrlValidator.prototype.isValid = function() {
  return this.URL_VALIDATION_REGEX.test(this.url);
};