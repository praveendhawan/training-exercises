function Days(checkboxList, noneCheckbox) {
  this.checkboxList = checkboxList;
  this.noneCheckbox = noneCheckbox;
  this.markedBoxes = [];
  this.maximumCheckedDays = 3;
}

Days.prototype.bindEvents = function() {
  var _this = this, 
    length = this.checkboxList.length;
  for(var i = 0; i < length; i++){
    this.checkboxList[i].addEventListener("click", function() { _this.markChecked(this); } );
  }
  this.noneCheckbox.addEventListener("click", function() { _this.unCheckAll(); } );
};

Days.prototype.markChecked = function(targetCheckbox) {
  // for checking if none checkbox is selected
  if (this.noneCheckbox.checked === true) {
    this.noneCheckbox.checked = false;
  }

  if(targetCheckbox.checked === true) {
    //max3check will be called for checking whether we have selected 3 checkboxes or not
    this.max3Check(targetCheckbox);
  }
  // if we deselect a checkbox we have to pop it from array
  else{
    this.removeCheckbox(targetCheckbox);
  }
};

Days.prototype.max3Check = function(targetCheckbox) {
  if(this.markedBoxes.length >= this.maximumCheckedDays) {
    targetCheckbox.checked = false;
    this.showAlert();
  }
  else {
    this.markedBoxes.push(targetCheckbox);
  }
};

Days.prototype.showAlert = function() {
  var message = "Only " + this.maximumCheckedDays + " " +
    "days can be selected.You have already selected ";

  for(var i = 0; i < this.maximumCheckedDays - 1; i++) {
    message += this.markedBoxes[i].value;
    if (!(i === this.maximumCheckedDays - 2)) {
      message += ", ";
    }
  }

  message += " and " + this.markedBoxes[this.maximumCheckedDays - 1].value;
  alert(message);
  
};

Days.prototype.unCheckAll = function() {
  for(var i = this.markedBoxes.length - 1; i >= 0; i--){
    this.markedBoxes[i].checked = false;
    this.markedBoxes.pop();
  }
};

Days.prototype.removeCheckbox = function(targetCheckbox) {
  var position = this.markedBoxes.indexOf(targetCheckbox);
  this.markedBoxes.splice(position, 1);
};

window.onload = function(){
  var container = document.getElementById("container"),
    checkboxList = container.querySelectorAll(".selector"),
    noneCheckbox = container.querySelector("#none"),
    checkboxes = new Days(checkboxList, noneCheckbox);
  checkboxes.bindEvents();
};