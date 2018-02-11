$(function() {
  var $contactMgrContainer = $('div.contact-manager');
  var requiredElements = {
    addForm: $contactMgrContainer.find('form.add-contact'),
    nameInputField: $contactMgrContainer.find('input.name'),
    emailInputFIeld: $contactMgrContainer.find('input.email'),
    addButton: $contactMgrContainer.find('input.addBtn'),
    searchField: $contactMgrContainer.find('input.search'),
    contactsContainer: $('div.contact-details'),
    listViewBtn: $contactMgrContainer.find('input.listViewBtn'),
    gridViewBtn: $contactMgrContainer.find('input.gridViewBtn')
  };
  var contactManager = new ContactManager(requiredElements);
  contactManager.bindEvents();
})