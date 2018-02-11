function ContactManager(elements) {
  // use simple [] instead of json here.
  this.contactList = [];
  this.filteredContact = [];
  // also hava a filteredContact list and use this to display contacts. By default it would be equal to contactList
  this.$addForm = elements.addForm;
  this.$addButton = elements.addButton;
  this.$searchField = elements.searchField;
  this.$nameInputField = elements.nameInputField;
  this.$emailInputFIeld = elements.emailInputFIeld;
  this.$contactsContainer = elements.contactsContainer;
  this.$listViewBtn = elements.listViewBtn;
  this.$gridViewBtn = elements.gridViewBtn;
  this.listView = false;
}

ContactManager.prototype.bindEvents = function() {
  this.$addButton.on('click', this.addNewContact());
  this.$searchField.on('keyup', this.searchContact());
  this.$searchField.closest('form').on('submit', this.preventfromSubmit());
  this.$contactsContainer.delegate('.deleteBtn', 'click', this.deleteContact());
  this.$listViewBtn.on('click', this.displayContactList());
  this.$gridViewBtn.on('click', this.displayContactGrid());
};

ContactManager.prototype.addNewContact = function() {
  var _this= this;
  return function(event) {
    if(_this.validateContact() && _this.isDuplicateContact()) {
      _this.displayNewContact(_this.generateContact());
    }
    event.preventDefault();
  }
};

// rename this method to validateContact. Also break it into two functions. one for name and other for email validations
ContactManager.prototype.validateContact = function() {
  if(this.$nameInputField.val().trim() && this.$emailInputFIeld.val().trim()) {
    var email = new Email(this.$emailInputFIeld.val()),
      status = email.isValid(),
      message = 'Please enter a valid email address';
    this.showError(message, status);
    return status;
  } else {
    message = 'Please enter valid details';
    this.showError(message, false);
  }
};

ContactManager.prototype.validatePresence = function(element) {
};

ContactManager.prototype.isDuplicateContact = function() {
  // this is not the status, rename it to is_duplicate.
  var status = true,
    name = this.$nameInputField.val().trim(),
    email = this.$emailInputFIeld.val().trim();
  $(this.contactList.contacts).each(function() {
    // we have a better way to do this
    status = status && !(this.name == name);
  });
  var message = 'This contact Already Exists.';
  this.showError(message, status);
  return status;
};

ContactManager.prototype.generateContact = function() {
  var name = this.$nameInputField.val().trim(),
    email = this.$emailInputFIeld.val().trim();
  return (new Contact(name, email));
};

ContactManager.prototype.displayNewContact = function(newContact) {
  this.contactList.contacts.push(newContact);
  var length = this.contactList.length;
  // newContact.setIndex(length);
  // refactor this
  container = this.listView ? this.makeListContainer(newContact, length) : this.makeGridContainer(newContact, length);
  this.listView ? this.$contactsContainer.find('table').append(container): this.$contactsContainer.append(container);
};

ContactManager.prototype.makeGridContainer = function(contact, id) {
  // variable names should not contain html tags
  // var nameSpan = $('<span/>', { text: `${ contact.name }` }),
    // emailSpan =  $('<span/>', { text: `${ contact.email }` }),
    var nameElement = $('<p/>', { text: 'Name: ' })
        .append($('<span/>', { text: `${ contact.name }` })),
      emailPara = $('<p/>', { text: 'Email: ' })
        .append($('<span/>', { text: `${ contact.email }` })),
    $deleteButton = $('<button>', { text: 'Delete', class: 'deleteBtn'}),
    $container = $('<div/>', { id: `${ id }` })
      .append(namePara, emailPara, $deleteButton)
      .addClass('contacts')
      .data('contactDetails', contact);
  return $container;
};

ContactManager.prototype.makeListContainer = function(contact, id) {
  var nameColumn = $('<td/>', { text: `${ contact.name }` }),
    emailColumn = $('<td/>', { text: `${ contact.email }` }),
    $deleteButtonColumn = $('<td/>').append($('<button>', { text: 'Delete', class: 'deleteBtn'}));
    containerRow = $('<tr/>', { id: `${ id }` })
      .append(nameColumn, emailColumn, $deleteButtonColumn)
      .addClass('contacts')
      .data('contactDetails', contact);
    return containerRow;
};

ContactManager.prototype.deleteContact = function() {
  var _this = this;
  return function() {
    var $currentContactContainer = $(this).closest('div,tr'),
    contact = $currentContactContainer.data('contactDetails'),
      index = _this.contactList.contacts.indexOf(contact);
    if(_this.confirmDeleteRequest(contact.name)) {
      _this.contactList.contacts.splice(index - 1, 1);
      $currentContactContainer.remove();
    }
  }
};

ContactManager.prototype.confirmDeleteRequest = function(name) {
  return confirm('Are you sure you want to delete contact ' + name + '?')
};

ContactManager.prototype.showError = function(message, status) {
  // This method should be independent of the status.
  if(!status) {
    alert(message);
  }
};

ContactManager.prototype.searchContact = function() {
  var _this = this;
  return function(event) {
    // remove duplicatcy
    var currentText = _this.$searchField.val().trim()
    if(currentText){
      // var currentText = _this.$searchField.val().trim(),
        currentRegexp = new RegExp(currentText, 'i');
        // rename showhidecontacts to displayFiltered contacts
      _this.displayFilteredContacts(currentRegexp);
    } else {
      _this.showAllContacts();
    }
  }
};

ContactManager.prototype.preventfromSubmit = function() {
  return function(event) {
    event.preventDefault();
  }
};

ContactManager.prototype.displayFilteredContacts = function(currentRegexp) {
  var _this = this;
  $(this.contactList.contacts).each(function(index, contact) {
  if(!currentRegexp.test(contact.name)) {
    _this.$contactsContainer.find(`div#${index + 1},tr#${index + 1}`).hide();
  } else {
    _this.$contactsContainer.find(`div#${index + 1},tr#${index + 1}`).show();
  }
})
};

ContactManager.prototype.showAllContacts = function() {
  this.toggleView(this.contactList.contacts);
};

ContactManager.prototype.displayContactList = function() {
  //refactor
  var _this = this;
  return function () {
    _this.listView = true;
    if(!$('table').length) {
      var currentlyVisibleContacts = [];
      _this.$contactsContainer.find('div.contacts:visible')
        .each(function(index, contactContainer) {
          currentlyVisibleContacts.push($(contactContainer).data('contactDetails'));
        });
      _this.toggleView(currentlyVisibleContacts);
    }
  }
};

ContactManager.prototype.toggleView = function(currentlyVisibleContacts) {
  // refactor
  var _this = this;
  this.$contactsContainer.empty();
  if(this.listView){
    var headingRow = $('<tr/>').append($('<th/>', { text: 'Name' }), $('<th/>', { text: 'Email'}), $('<th/>', { text: 'Action' }));
      _this.$contactsContainer.append($('<table/>').append(headingRow));
    var tableList = this.$contactsContainer.find('table');
    $(currentlyVisibleContacts).each(function(index, contact){
      var container = _this.makeListContainer(contact, (index + 1));
      tableList.append(container);
    })
  } else {
    $(currentlyVisibleContacts).each(function(index, contact){
      var container = _this.makeGridContainer(contact, (index + 1));
      _this.$contactsContainer.append(container);
    })
  }
};

ContactManager.prototype.displayContactGrid = function() {
  var _this = this;
  return function() {
    if(_this.listView){
      _this.listView = false;
      var currentlyVisibleContacts = [];
      _this.$contactsContainer.find('tr.contacts:visible')
        .each(function(index, contactContainer) {
          currentlyVisibleContacts.push($(contactContainer).data('contactDetails'));
        })
      _this.toggleView(currentlyVisibleContacts);
    }
  }
};

// fix validation and search
// refactor
// list view
// grid view - default 
// ask for confirmation before delete "are you sure to delete username"

