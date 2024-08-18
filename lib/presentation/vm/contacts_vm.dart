import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:phone_book_app/models/contact_model.dart';


// Provider for ContactViewModel, auto-disposed when not in use
final contactViewModelProvider = ChangeNotifierProvider.autoDispose<ContactViewModel>((ref) {
  return ContactViewModel.init();
});

class ContactViewModel extends ChangeNotifier {
  final contactsList = ContactsList.fromJson(json.decode(jsonString));
  ContactViewModel.init() {
    setContacts(contactsList.contacts);
  }
  List<Contact> _contacts = [];
  List<Contact> get contacts => _contacts;

  void setContacts(List<Contact> contacts) {
    _contacts = contacts;
    notifyListeners();
  }

  void addContact(Contact contact) {
    _contacts.add(contact);
    notifyListeners();
  }

  void editContact(String id, Contact updatedContact) {
    int index = _contacts.indexWhere((contact) => contact.id == id);
    if (index != -1) {
      _contacts[index] = updatedContact;
      notifyListeners();
    }
  }

// Method to delete a contact based on ID
  void deleteContact(String id) {
    _contacts.removeWhere((contact) => contact.id == id);
    notifyListeners();
  }

  String _searchQuery = "";
  void searchContacts(String query) {
    _searchQuery = query.toLowerCase();
    notifyListeners();
  }


// Method to get the filtered list of contacts based on the search query
  List<Contact> get allFilteredContacts {
    try {
      return contacts
          .where((item) =>
              item.name.toLowerCase().contains(_searchQuery) || item.phone.toLowerCase().contains(_searchQuery))
          .toList();
    } catch (e) {
      return [];
    }
  }
}
