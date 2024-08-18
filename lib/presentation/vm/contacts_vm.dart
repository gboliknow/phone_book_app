import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:phone_book_app/models/contact_model.dart';

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

  void deleteContact(String id) {
    _contacts.removeWhere((contact) => contact.id == id);
    notifyListeners();
  }

  String _searchQuery = "";
  void searchContacts(String query) {
    _searchQuery = query.toLowerCase();
    notifyListeners();
  }

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

String jsonString = '''
  {
    "contacts": [
      {
        "id": "1",
        "name": "Alice Johnson",
        "phone": "+1234567890",
        "avatar": "https://picsum.photos/200/300"
      },
      {
        "id": "2",
        "name": "Bob Smith",
        "phone": "+0987654321",
        "avatar": "https://picsum.photos/200/300"
      },
      {
        "id": "3",
        "name": "Charlie Brown",
        "phone": "+1122334455",
        "avatar": "https://picsum.photos/200/300"
      },
      {
        "id": "4",
        "name": "David Williams",
        "phone": "+5566778899",
        "avatar": "https://picsum.photos/200/300"
      },
      {
        "id": "5",
        "name": "Eva Green",
        "phone": "+2244668800",
        "avatar": "https://picsum.photos/200/300"
      }
    ]
  }
  ''';

class ContactsList {
  final List<Contact> contacts;

  ContactsList({required this.contacts});

  // Factory constructor to create a ContactsList from JSON
  factory ContactsList.fromJson(Map<String, dynamic> json) {
    var list = json['contacts'] as List;
    List<Contact> contactsList = list.map((i) => Contact.fromJson(i)).toList();

    return ContactsList(contacts: contactsList);
  }

  // Method to convert a ContactsList to JSON
  Map<String, dynamic> toJson() {
    return {
      'contacts': contacts.map((contact) => contact.toJson()).toList(),
    };
  }
}
