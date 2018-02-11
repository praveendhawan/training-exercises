function URL(urlList, submitButton) {
  this.urlList = urlList;
  this.submitButton = submitButton; 
}

URL.prototype.URL_REGEX = /^(http[s]?:\/\/){0,1}(www.){0,1}([\w]+.)?([\w]+.){0,1}([\w]{2,5})$/;

URL.prototype.bindEvents = function() {
  var _this = this;
  this.submitButton.addEventListener("click", function() { _this.showResult(); })
};

URL.prototype.extractDomainSubdomain = function(url) {
  this.URL_REGEX.test(url);
  return RegExp.$4 ? { 'domain': RegExp.$4 + RegExp.$5, 'subdomain': RegExp.$3 } : { 'domain': RegExp.$3 + RegExp.$5, 'subdomain': ''};
};

URL.prototype.showResult = function() {
  for(var i = 0; i < this.urlList.length; i++) {
    var result = this.extractDomainSubdomain(this.urlList[i].value);
    if(result.subdomain) {
      message = `Domain : ${ result.domain } Subdomain: ${ result.subdomain }`;
    } else {
      message = `Domain : ${ result.domain }`;
    }
    alert(message);
  }
};

window.onload = function() {
  var myform = document.getElementsByClassName("myform")[0],
    url = new URL(myform.querySelectorAll(".input-url"), myform.querySelector("#submit-button"));
  url.bindEvents();
}