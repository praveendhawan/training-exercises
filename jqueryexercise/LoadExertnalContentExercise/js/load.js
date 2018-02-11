function BlogPost(blogHeadings) {
  this.blogHeadings = blogHeadings
}

BlogPost.prototype.init = function() {
  var $target = $('<div/>');
  this.blogHeadings.after($target).data('blogData', $target);
  this.bindEvents();
};

BlogPost.prototype.bindEvents = function() {
  this.blogHeadings.on('click', this.showPost());
};

BlogPost.prototype.showPost = function() {
  return function(event) {
    event.preventDefault();
    var $target = $(this).next(),
      postId = $(this).find('a').attr('href').split('#')[1];
    $target.load('data/blog.html div#' + postId);
  }
};

$(function() {
  var blogHeadings = $('div#blog h3');
  var blogPosts = new BlogPost(blogHeadings);
  blogPosts.init();
})