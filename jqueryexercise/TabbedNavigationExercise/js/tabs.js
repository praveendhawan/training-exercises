function Tabs(modules) {
  this.tabsContent = modules;
}

Tabs.prototype.init = function() {
  var _this = this;
  this.tabList = $('<ul></ul>').addClass('newUL');
  $(this.tabsContent[0]).before(this.tabList);
  var headings = this.extractHeadings();
  var removedHeader = this.detachHeader();
  this.addToUl(removedHeader, headings);
  this.tabsContent.hide();
  this.bindEvents();
  this.showFirstTab();
};

Tabs.prototype.bindEvents = function() {
  var _this = this;
  this.tabList.delegate('li', 'click', _this.toggler() );
};

Tabs.prototype.detachHeader = function() {
  return this.tabsContent.each(function (index, element) {
    $(element).find('h2').remove();
  });
};

Tabs.prototype.extractHeadings = function() {
  var headings = [];
  this.tabsContent.each(function (index, element) {
    headings.push($(element).find('h2').text());
  });
  return headings
};

Tabs.prototype.addToUl = function(removedHeaderElements, headings) {
  var _this = this;
  removedHeaderElements.each(function (index, element) {
    var listItem = $('<li></li>').text(headings[index]).append(removedHeaderElements[index]);4
    _this.tabList.append(listItem);
  });
};


Tabs.prototype.toggler = function() {
  var _this = this;
  return function() {
    $(this).toggleClass('current');
    $(this).find('div').toggle();
    $(this).siblings().removeClass('current').find('div').hide();
  };
};

Tabs.prototype.showFirstTab = function() {
  $(this.tabList).find('li:first').addClass('current').find('div').show();
};

$(function() {
  var modules = $('div.module');
  var TabbedNavigator = new Tabs(modules);
  TabbedNavigator.init();
});