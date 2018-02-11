function Blogs($blogContainer) {
  this.$blogContainer = $blogContainer;
};

Blogs.prototype.init = function() {
  this.bindEvents();
};

Blogs.prototype.bindEvents = function() {
  var _this = this;
  this.$blogContainer.find('h3').delegate('a', 'click', _this.toggler() );
};

Blogs.prototype.toggler = function() {
  return function(event) {
    event.preventDefault();
    var $listElement = $(this).closest('li');
    $listElement.siblings().find('p.excerpt').slideUp('slow');
    $listElement.find('p.excerpt').slideToggle('slow');
  };
};

$(function() {
  var $blogContainer = $('div#blog');
  var blogs = new Blogs($blogContainer);
  blogs.init();
})