function CountrySelect(countryToSelect, selectedCountry, addButton, removeButton) {
  this.countryToSelect = countryToSelect;
  this.selectedCountries = selectedCountry;
  this.addButton = addButton;
  this.removeButton = removeButton;
}

CountrySelect.prototype.bindEvents = function() {
  var _this = this;

  this.addButton.addEventListener("click", 
    _this.addAndRemove(_this.countryToSelect, _this.selectedCountries) );

  this.removeButton.addEventListener("click", 
    _this.addAndRemove(_this.selectedCountries, _this.countryToSelect) );

};

CountrySelect.prototype.getSelectedItem = function(selectBox) {
  return selectBox.options[this.getSelectedItemIndex(selectBox)];  
};

CountrySelect.prototype.getSelectedItemIndex = function(selectBox) {
  return selectBox.selectedIndex;
};


CountrySelect.prototype.addAndRemove = function(removeFrom, addTo) {
  var _this = this;
  // this is done to reserve the scope of both event target and event handler
  return function() {
    var markedCountry = _this.getSelectedItem(removeFrom),
    index = _this.getSelectedItemIndex(removeFrom);
    if(index > -1) {
      removeFrom.remove(index);
      addTo.add(markedCountry);
      addTo.selectedIndex = -1;
      removeFrom.selectedIndex = -1;
    }
  }
  
};

window.onload = function() {
  var countryToSelect = document.getElementById("to-select"),
    selectedCountry = document.getElementById("selected"),
    addButton = document.getElementById("add"),
    removeButton = document.getElementById("remove");
  var countrySelect = new CountrySelect(countryToSelect, selectedCountry, addButton, removeButton);
  countrySelect.bindEvents();
}