function Slideshow($slidesElements) {
  this.$slidesElements = $slidesElements;
};

Slideshow.prototype.init = function() {
  this.navTotalCount = $('<p/>', { text : 'Total = ' + this.$slidesElements.length, style: 'display:inline'  });
  this.navCurrent = $('<p/>', { style: 'display:inline; position:relative; left: 300px;' });
  var mainDiv = $('#main');
  mainDiv.prepend($('<div/>').append(this.navTotalCount, this.navCurrent));
  this.$slidesElements.addClass('customClass');
  mainDiv.prepend(this.$slidesElements);
  this.$slidesElements.hide();
  this.currentSlideNumber = 0;
  this.fadeInCurrentSlide();
};

Slideshow.prototype.fadeInCurrentSlide = function() {
  var _this = this;
  this.navCurrent.text('Current = ' + (_this.currentSlideNumber + 1));
  this.$slidesElements
    .eq(this.currentSlideNumber)
    .fadeIn(1500, function () {
      _this.fadeOutCurrentSlide();
    });
};

Slideshow.prototype.fadeOutCurrentSlide = function() {
  var _this = this;
  this.$slidesElements
    .eq(this.currentSlideNumber)
    .fadeOut(1500, function() {
      _this.setCurrentSlideNumber();
      _this.fadeInCurrentSlide();
    })
};

Slideshow.prototype.setCurrentSlideNumber = function() {
  this.currentSlideNumber++;
      if(!(this.currentSlideNumber % this.$slidesElements.length)) {
        this.currentSlideNumber = 0;
      }
};

$(function () {
  var $$slidesElements = $('#slideshow li');
  var slideshow = new Slideshow($$slidesElements);
  slideshow.init();
})