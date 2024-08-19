import 'package:flutter_test/flutter_test.dart';
import 'package:phone_book_app/models/contact_model.dart';
import 'package:phone_book_app/presentation/vm/contacts_vm.dart';

void main() {
  late ContactViewModel contactViewModel;

  setUp(() {
    contactViewModel = ContactViewModel.init();
  });

  test('Initial contacts are set correctly', () {
    expect(contactViewModel.contacts.length, 5);
  });

  test('Add a new contact', () {
    final newContact = Contact(
      id: '6',
      name: 'New Contact',
      phone: '+1234567899',
      avatar: 'https://picsum.photos/200/300',
    );

    contactViewModel.addContact(newContact);

    expect(contactViewModel.contacts.length, 6);
    expect(contactViewModel.contacts.last.name, 'New Contact');
  });

  test('Edit an existing contact', () {
    final updatedContact = Contact(
      id: '1',
      name: 'Updated Name',
      phone: '+1234567890',
      avatar: 'https://picsum.photos/200/300',
    );

    contactViewModel.editContact('1', updatedContact);

    expect(contactViewModel.contacts.firstWhere((c) => c.id == '1').name, 'Updated Name');
  });

  test('Delete a contact', () {
    contactViewModel.deleteContact('1');

    expect(contactViewModel.contacts.length, 4);
    expect(contactViewModel.contacts.where((c) => c.id == '1').isEmpty, true);
  });

  test('Search contacts', () {
    contactViewModel.searchContacts('Alice');

    expect(contactViewModel.allFilteredContacts.length, 1);
    expect(contactViewModel.allFilteredContacts.first.name, 'Alice Johnson');
  });
}
