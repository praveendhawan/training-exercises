function CheckboxSelector(checkboxes, checkAllLink, uncheckAllLink){
  this.boxlist = checkboxes;
  this.checkall = checkAllLink;
  this.uncheckall = uncheckAllLink;
}

CheckboxSelector.prototype.bindEvents = function(){
  this.checkall.addEventListener("click", this.checkAll.bind(this, true));
  this.uncheckall.addEventListener("click", this.checkAll.bind(this, false));
};

CheckboxSelector.prototype.checkAll = function(checked){
  var length = this.boxlist.length;
  for(var i = 0; i < length; i++){
    this.boxlist[i].checked = checked;
  }
};

window.onload = function(){
  var checkboxes = document.querySelectorAll(".selector");
  var checkAllLink = document.querySelector(".checkAll");
  var uncheckAllLink = document.querySelector(".checkNone");
  var checkboxChooser = new CheckboxSelector(checkboxes, checkAllLink, uncheckAllLink);
  checkboxChooser.bindEvents();
};