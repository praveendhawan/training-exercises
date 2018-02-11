$(function() {
  // Select all of the div elements that have a class of "module".
  $('div.module');
  // Come up with three selectors that you could use to get the third item in the 
  //   #myList unordered list. Which is the best to use? Why?
  //best way to select an item is id because id is unique on the page and jquery uses 
  // javascripts getElementById() which is very efficient
  $('#myList li:nth-child(3)');

  $('#myList li').eq(2); // newly added selector
  $('#myList li:eq(2)'); // newly added selector
                         // difference between these two is that :eq() cannot 
                         // have -ve arguments while .eq() can.

  $('#myListItem');

  $("li[id='myListItem']");

  // Select the label for the search input using an attribute selector
  $("label[for='q']");

  // Figure out how many elements on the page are hidden
  $(":hidden").length;

  // Figure out how many image elements on the page have an alt attribute
  $("img[alt]").length;

  // Select all of the odd table rows in the table body
  $("table tbody tr:even");
});