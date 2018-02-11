function Navigation(navigationLi) {
  this.navigationLi = navigationLi;
};

Navigation.prototype.init = function() {
  this.bindEvents();
};

Navigation.prototype.bindEvents = function() {
  $(this.navigationLi).on('mouseenter mouseleave', this.toggler);
};

Navigation.prototype.toggler = function() {
  $(this).find('ul').toggle().end().toggleClass('hover');
};


$(function() {
  var $navigationLi = $('ul#nav li');
  var navigation = new Navigation($navigationLi);
  navigation.init();
})