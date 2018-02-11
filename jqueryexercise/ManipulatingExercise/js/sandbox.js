$(function() {
  // Add five new list items to the end of the unordered list #myList.
  function MakeLiItems() {
    var listItems = $();
    for(var i = 0; i < 5; i++) {
      listItems = listItems.add($('<li>', { text: "New List Item" + (i + 1) }));
    }
    return listItems;
  }
  
  $('#myList').append(MakeLiItems);

  // Remove the odd list items
  $('#myList li:odd').remove();

  //  Add another h2 and another paragraph to the last div.module
  $('div.module:last').prepend($('<h2>', { text: 'Heading2'}), $('<p>', { text: 'Paragraph'}));
  
  // Add another option to the select element; give the option the value "Wednesday"
  $('div.module select[name="day"]').append($('<option>', { value: 'wednessday', text: 'Wednessday' }));

  // Add a new div.module to the page after the last one; put a copy of one of the 
  //existing images inside of it.
  $('div.module:last')
    .after($('<div>', { class: 'module'})
    .append($('#slideshow img[alt="fruit"]').clone()
    ));
  });