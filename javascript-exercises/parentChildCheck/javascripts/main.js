function CheckboxSelector(parentCheckboxes) {
  this.parentCheckboxes = parentCheckboxes;
}

CheckboxSelector.prototype.bindEvents = function() {
  var _this = this;
  var length = this.parentCheckboxes.length;
  for( var i = 0; i < length; i++){
    this.parentCheckboxes[i].addEventListener("click", function(e){ _this.checkUncheck(e, this); });
  }
};

CheckboxSelector.prototype.checkUncheck = function(event, parentCheckbox) {
  if(!parentCheckbox.checked){
    this.checkAllChildren(parentCheckbox, false);
  }
  else {
    this.checkAllChildren(parentCheckbox, true);
  }
  event.stopPropagation();
};

CheckboxSelector.prototype.checkAllChildren = function(parentCheckbox, status) {
  var display = "none";
  if(status) {
    display = "block";
    parentCheckbox.parentNode.scrollIntoView({block: "start", behavior: "smooth"});
  }
  this.toggleDisplay(parentCheckbox, display);
  var children = parentCheckbox.parentNode.querySelectorAll(".children");
  var length = children.length;
  for(var i = 0; i < length; i++){
    children[i].checked = status;
  }
};


CheckboxSelector.prototype.toggleDisplay = function(parentCheckbox, displayValue) {
  var childrenContainer = parentCheckbox.parentNode.querySelector(".children_container");
  childrenContainer.style.display = displayValue;
};

window.onload = function() {
  var parentCheckboxes = document.getElementsByClassName("parent");
  var checkboxSelector = new CheckboxSelector(parentCheckboxes);
  checkboxSelector.bindEvents();
};