function Stack(container) {
  this.container = container;
  this.stack = container.find('div#stack');
  this.addItemButton = container.find('button#addItem');
  this.counter = 1;
}

Stack.prototype.init = function() {
  this.bindEvents();
};

Stack.prototype.bindEvents = function() {
  this.addItemButton.on('click', this.addNewItem());
  this.stack.delegate('div.item', 'click', this.changeColorOrRemove());
};

Stack.prototype.addNewItem = function() {
  var _this = this;
  return function() {
    var newItem = new Item($('<div/>', { text: `New Item ${ _this.counter }`, class: 'item' }));
    _this.pushItem(newItem);
  }
};

Stack.prototype.pushItem = function(item) {
  this.counter++;
  this.stack.prepend(item.$itemDiv);
};

Stack.prototype.changeColorOrRemove = function() {
  var _this = this;
  return function() {
    if(!$(this).index()) {
      $(this).remove();
      _this.counter--;
    } else {
      $(this).addClass('chageColor');
    }

  }
};

$(function() {
  var container = $('div.container');
  var stack = new Stack(container);
  stack.init();
})