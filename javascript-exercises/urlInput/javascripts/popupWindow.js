function PopupWindow() {
  this.locationUrl = "";
};

PopupWindow.prototype.init = function() {
  this.getInput();
  this.valid = this.validateUrl()
  this.showResult();
};

PopupWindow.prototype.getInput = function() {
  this.locationUrl = prompt("Enter a url");
};

PopupWindow.prototype.validateUrl = function() {
  return !(this.locationUrl === null || this.locationUrl.trim() === "")
};

PopupWindow.prototype.showResult = function() {
  if(this.valid) {
    this.openWindow();
  } else {
    alert("Url you enetered is not valid");
  }
};

PopupWindow.prototype.openWindow = function() {
  window.open(this.locationUrl, "mywindow", "height=450,width=400,scrollbars=no,menubar=no,location=no,toolbar=no,status=no");
};

window.onload = function() {
  popupWindow = new PopupWindow();
  popupWindow.init()
}