$(function() {
  // Select all of the image elements on the page; log each image's alt attribute.
  $('img').each(function(index, element) {
    console.log($(element).attr('alt'));
  });

  // Select the search input text box, then traverse up to the form and add a 
  //class to the form.
  $('#search input[type="text"]').parents('#search').addClass('myCustomClass');

  // Select the list item inside #myList that has a class of "current" and remove 
  //that class from it; add a class of "current" to the next list item.
  $('#myList li.current').removeClass('current').next().addClass('current');

  // Select the select element inside #specials; traverse your way to the submit button.
  $('#specials select').parents('ul').find('input.input_submit');

  // Select the first list item in the #slideshow element; add the class "current" to it,
  // and then add a class of "disabled" to its sibling elements.
  $('#slideshow li:first').addClass('current').siblings().addClass('disabled');
});