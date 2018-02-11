function InputHint(searchForm) {
  this.labelField = searchForm.labelField;
  this.searchField = searchForm.searchField;
};

InputHint.prototype.init = function() {
  this.searchField.val(this.labelField.text());
  this.searchField.addClass('hint');
  this.labelField.hide();
  this.bindEvents();
};

InputHint.prototype.bindEvents = function() {
  var _this = this;
  this.searchField.bind('focus', function(e) { _this.focusHandler(); });
  this.searchField.bind('blur', function(e) { _this.blurHandler(); });

};

InputHint.prototype.focusHandler = function() {
  this.searchField.removeClass('hint');
  // no need of this.isEmpty() in if condition
  if(this.isEmpty() || this.searchField.attr('value') === this.labelField.text()) {
    this.searchField.val('');
  }
};

InputHint.prototype.blurHandler = function() {
  this.searchField.addClass('hint');
  if(this.isEmpty()) {
    this.searchField.val(this.labelField.text());
  }
};

InputHint.prototype.isEmpty = function() {
  return !this.searchField.attr('value').trim();
};

$(function() {
  var searchForm = {
    labelField: $('#search label[for="q"]'),
    searchField: $('#search input.input_text')
  };
  var inputHintObject = new InputHint(searchForm);
  inputHintObject.init();
});