function ContactManager(elements) {
  this.contactList = {};
  this.filteredContact = {};
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
    if(_this.validateContact() && !_this.isDuplicateContact()) {
      _this.displayNewContact(_this.generateContact());
    }
    event.preventDefault();
  }
};

ContactManager.prototype.validateContact = function() {
  var nameInput = this.$nameInputField.val().trim(),
    emailInput = this.$emailInputFIeld.val().trim(),
    isValid = false;
  if(this.validatePresence(nameInput) && this.validatePresence(emailInput)) {
    isValid = this.validateEmail(emailInput);
  } else {
    message = 'Please enter valid details';
    this.showError(message);
  }
  return isValid;
};

ContactManager.prototype.validatePresence = function(element) {
  return element.length;
};

ContactManager.prototype.validateEmail = function(emailInput) {
  var email = new Email(emailInput),
  message = 'Please enter a valid email address';
  if(!email.isValid()){
    this.showError(message);
    return false;
  }
  return true;
};

ContactManager.prototype.isDuplicateContact = function() {
  var isDuplicate = true,
    name = this.$nameInputField.val().trim();
  if(this.contactList[name]) {
    isDuplicate = false;
    var message = 'This contact Already Exists.';
    this.showError(message);
  }
  return !isDuplicate;
};

ContactManager.prototype.generateContact = function() {
  var name = this.$nameInputField.val().trim(),
    email = this.$emailInputFIeld.val().trim();
  return (new Contact(name, email));
};

ContactManager.prototype.displayNewContact = function(newContact) {
  this.contactList[newContact.name] = newContact;
  this.filteredContact[newContact.name] = newContact;
  var length = Object.keys(this.contactList).length;
  this.listView ? this.addContactToList(newContact, length) : this.addContactToGrid(newContact, length);
};

ContactManager.prototype.addContactToList = function(contact, id) {
  var container = this.makeListContainer(contact, id);
  this.$contactsContainer.find('table').append(container);
};

ContactManager.prototype.addContactToGrid = function(contact, id) {
  var container = this.makeGridContainer(contact, id);
  this.$contactsContainer.append(container);
};

ContactManager.prototype.makeGridContainer = function(contact, id) {
    var $nameElement = $('<p/>', { text: 'Name: ' })
        .append($('<span/>', { text: `${ contact.name }` })),
      $emailElement = $('<p/>', { text: 'Email: ' })
        .append($('<span/>', { text: `${ contact.email }` })),
    $deleteElement = $('<button>', { text: 'Delete', class: 'deleteBtn'}),
    $container = $('<div/>', { id: `${ id }` })
      .append($nameElement, $emailElement, $deleteElement)
      .addClass('contacts')
      .data('contactDetails', contact);
  return $container;
};

ContactManager.prototype.makeListContainer = function(contact, id) {
  var nameElement = $('<td/>', { text: `${ contact.name }` }),
    emailElement = $('<td/>', { text: `${ contact.email }` }),
    $deleteElement= $('<td/>').append($('<button>', { text: 'Delete', class: 'deleteBtn'}));
    containerRow = $('<tr/>', { id: `${ id }` })
      .append(nameElement, emailElement, $deleteElement)
      .addClass('contacts')
      .data('contactDetails', contact);
    return containerRow;
};

ContactManager.prototype.deleteContact = function() {
  var _this = this;
  return function() {
    var $currentContactContainer = $(this).closest('div,tr'),
    contact = $currentContactContainer.data('contactDetails');
    if(_this.confirmDeleteRequest(contact.name)) {
      delete _this.contactList[contact.name];
      delete _this.filteredContact[contact.name];
      $currentContactContainer.remove();
    }
  }
};

ContactManager.prototype.confirmDeleteRequest = function(name) {
  return confirm('Are you sure you want to delete contact ' + name + '?')
};

ContactManager.prototype.showError = function(message) {
  alert(message);
};

ContactManager.prototype.preventfromSubmit = function() {
  return function(event) {
    event.preventDefault();
  }
};

ContactManager.prototype.searchContact = function() {
  var _this = this;
  return function(event) {
    var currentText = _this.$searchField.val().trim();
    if(currentText){
      currentRegexp = new RegExp(currentText, 'i');
      _this.resetFilteredContacts();
      _this.displayFilteredContacts(currentRegexp);
    } else {
      _this.showAllContacts();
    }
  }
};

ContactManager.prototype.resetFilteredContacts = function() {
  for(contactName in this.filteredContact) {
    delete this.filteredContact[contactName];
  }
};

ContactManager.prototype.displayFilteredContacts = function(currentRegexp) {
  var _this = this,
    index = 0;
  for(var contactName in this.contactList) {
    if(!currentRegexp.test(this.contactList[contactName].name)) {
      delete _this.filteredContact[contactName];
      _this.$contactsContainer.find(`div#${index + 1},tr#${index + 1}`).hide();
    } else {
      _this.filteredContact[contactName] = _this.contactList[contactName];
      var filteredSelections = _this.$contactsContainer.find(`div#${index + 1},tr#${index + 1}`);
      if(!filteredSelections.length) {
        _this.toggleView(_this.findCurrentlyVisibleContacts());
      }
    }
    index++;
  }
};

ContactManager.prototype.showAllContacts = function() {
  var allContacts = [];
  for(var contactName in this.contactList) {
    allContacts.push(this.contactList[contactName]);
    this.filteredContact[contactName] = this.contactList[contactName];
  }
  this.toggleView(allContacts);
};

ContactManager.prototype.displayContactList = function() {
  var _this = this;
  return function () {
    _this.listView = true;
    if(!$('table').length) {
      _this.toggleView(_this.findCurrentlyVisibleContacts());
    }
  }
};

ContactManager.prototype.toggleView = function(currentlyVisibleContacts) {
  this.$contactsContainer.empty();
  if(this.listView){
    this.showInListView(currentlyVisibleContacts);
  } else {
    this.showInGridView(currentlyVisibleContacts);
  }
};

ContactManager.prototype.showInListView = function(currentlyVisibleContacts) {
  var _this = this;
  var headingRow = $('<tr/>').append($('<th/>', { text: 'Name' }), $('<th/>', { text: 'Email'}), $('<th/>', { text: 'Action' }));
  _this.$contactsContainer.append($('<table/>').append(headingRow));
  $(currentlyVisibleContacts).each(function(index, contact){
    var contactId = _this.findIndex(contact);
    _this.addContactToList(contact, contactId);
  })
};

ContactManager.prototype.showInGridView = function(currentlyVisibleContacts) {
  var _this = this;
  $(currentlyVisibleContacts).each(function(index, contact){
    var contactId = _this.findIndex(contact);
    _this.addContactToGrid(contact, contactId);
  })
};

ContactManager.prototype.findIndex = function(contact) {
  var x = Object.keys(this.contactList);
  var returnValue;
  $(x).each(function(index, element) {
    if(contact.name == element) {
      returnValue = index + 1;
    }
  })
  return returnValue;
};

ContactManager.prototype.displayContactGrid = function() {
  var _this = this;
  return function() {
    if(_this.listView){
      _this.listView = false;
      _this.toggleView(_this.findCurrentlyVisibleContacts());
    }
  }
};

ContactManager.prototype.findCurrentlyVisibleContacts = function() {
  var currentlyVisibleContacts = [];
  for(var contactName in this.filteredContact) {
    currentlyVisibleContacts.push(this.filteredContact[contactName])
  }
  return currentlyVisibleContacts;
};